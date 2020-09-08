//
//  WeatherLoader.swift
//  Homework
//
//  Created by Виталий Овсянников on 05.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit
import Alamofire

/* Краткие пояснения к коду
 1. Получение погоды на неделю является платной услугой на сайте Open Weather. Либо я не до конца разобрался. Потому существует два ключа  API в перечислении Constant: один мой, а другой рабочий 😂
 2. Вложенный метод getFinalData обрабатывает данные из jsonDict в необходимый формат. В связи с разными нотациями результатов данных для погоды на день и на неделю, в методах *current* и *daily* разные алгоритмы обработки
 */

enum Constant: String{
    case URLCurrent = "https://openweathermap.org/data/2.5/weather?q=Moscow,ru"
    case URL7Days = "https://openweathermap.org/data/2.5/forecast/daily?id=524901&cnt=7"
    
    case MyAPIKey = "&appid=d16591c5f4f24840a17a76f78f3d0721"
    case OpenAPIKey = "&appid=439d4b804bc8187953eb36d2a8c26a02"
}

protocol WeatherLoaderDelegate {
    func loaded(_ weather: [Weather])
}

class WeatherLoader{
    
    var delegate: WeatherLoaderDelegate?
    var weatherForecast: [Weather] = []
    
    func loadCurrentWeatherStandart(){
        func getFinalData(from jsonDict: NSDictionary) -> NSDictionary{
            var finalData = Dictionary<String, Any>()
            
            for (k, data) in jsonDict{
                if k as! String == "dt"{
                    finalData[k as! String] = data
                }
                if k as! String == "weather"{
                    for el in data as! NSArray{
                        for (key, dict) in  el as! NSDictionary{
                            if key as! String == "main"{
                                finalData["description"] = dict
                            }
                        }
                    }
                }
                if k as! String == "main"{
                    for (key, el) in data as! NSDictionary{
                        if key as! String == "temp"{
                            finalData[key as! String] = el
                        }
                    }
                }
            }
            
            return finalData as NSDictionary
        }
        
        let urlString = Constant.URLCurrent.rawValue + Constant.OpenAPIKey.rawValue
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
//                print("\n\njsonDict:")
//                print(jsonDict)
                
                if let w = Weather(data: getFinalData(from: jsonDict)){
                    self.weatherForecast.append(w)
                }
                DispatchQueue.main.async {
                    self.delegate?.loaded(self.weatherForecast)
                }
            }
        }
        task.resume()
    }
    
    func loadDialyWeatherStandart(){
        func getFinalData(from jsonDict: NSDictionary) -> NSDictionary{
            var finalData = Dictionary<String, Any>()
            
            for (k, data) in jsonDict{
                if k as! String == "dt"{
                    finalData[k as! String] = data
                }
                if k as! String == "weather"{
                    for el in data as! NSArray{
                        for (key, dict) in  el as! NSDictionary{
                            if key as! String == "main"{
                                finalData["description"] = dict
                            }
                        }
                    }
                }
                if k as! String == "temp"{
                    for (key, el) in data as! NSDictionary{
                        if key as! String == "day"{
                            finalData["temp"] = el
                        }
                    }
                }
            }
            
            return finalData as NSDictionary
        }
        
        let urlString = Constant.URL7Days.rawValue + Constant.OpenAPIKey.rawValue
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let jsonDict = json as? NSDictionary{
//                    print("\n\njsonDict:")
//                    print(jsonDict["list"])
                
                for dict in jsonDict["list"] as! NSArray {
                    if self.weatherForecast.count == 7{ break }
                    if let w = Weather(data: getFinalData(from: dict as! NSDictionary)){
                        self.weatherForecast.append(w)
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.loaded(self.weatherForecast)
                }
            }
        }
        task.resume()
    }
    
    func loadCurrentWeatherAlamofire(){
        func getFinalData(from jsonDict: NSDictionary) -> NSDictionary{
            var finalData = Dictionary<String, Any>()
            
            for (k, data) in jsonDict{
                if k as! String == "dt"{
                    finalData[k as! String] = data
                }
                if k as! String == "weather"{
                    for el in data as! NSArray{
                        for (key, dict) in  el as! NSDictionary{
                            if key as! String == "main"{
                                finalData["description"] = dict
                            }
                        }
                    }
                }
                if k as! String == "main"{
                    for (key, el) in data as! NSDictionary{
                        if key as! String == "temp"{
                            finalData[key as! String] = el
                        }
                    }
                }
            }
            
            return finalData as NSDictionary
        }
        
        let urlString = Constant.URLCurrent.rawValue + Constant.OpenAPIKey.rawValue
        Alamofire.request(urlString).responseJSON { response in
            if let objects = response.result.value,
                let jsonDict = objects as? NSDictionary{
                //                print("\n\njsonDict:")
                //                print(jsonDict)
                
                if let w = Weather(data: getFinalData(from: jsonDict)){
                    self.weatherForecast.append(w)
                }
                DispatchQueue.main.async {
                    self.delegate?.loaded(self.weatherForecast)
                }
            }
        }
    }
    
    func loadDialyWeatherAlamofire(){
        func getFinalData(from jsonDict: NSDictionary) -> NSDictionary{
            var finalData = Dictionary<String, Any>()
            
            for (k, data) in jsonDict{
                if k as! String == "dt"{
                    finalData[k as! String] = data
                }
                if k as! String == "weather"{
                    for el in data as! NSArray{
                        for (key, dict) in  el as! NSDictionary{
                            if key as! String == "main"{
                                finalData["description"] = dict
                            }
                        }
                    }
                }
                if k as! String == "temp"{
                    for (key, el) in data as! NSDictionary{
                        if key as! String == "day"{
                            finalData["temp"] = el
                        }
                    }
                }
            }
            
            return finalData as NSDictionary
        }
        
        let urlString = Constant.URL7Days.rawValue + Constant.OpenAPIKey.rawValue
        Alamofire.request(urlString).responseJSON{ response in
            if let objects = response.result.value,
                let jsonDict = objects as? NSDictionary{
                //                    print("\n\njsonDict:")
                //                    print(jsonDict["list"])
                
                for dict in jsonDict["list"] as! NSArray {
                    if self.weatherForecast.count == 7 { break }
                    if let w = Weather(data: getFinalData(from: dict as! NSDictionary)){
                        self.weatherForecast.append(w)
                    }
                }
                DispatchQueue.main.async {
                    self.delegate?.loaded(self.weatherForecast)
                }
            }
        }
    }
}
