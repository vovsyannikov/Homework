//
//  WeatherLoader.swift
//  Homework
//
//  Created by Виталий Овсянников on 05.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

enum Constant: String{
    case URLCurrent = "https://openweathermap.org/data/2.5/weather?q=Moscow,ru"
    case URL7Days = "https://openweathermap.org/data/2.5/forecast/daily?id=524901&cnt=7"
    
    case APIKey = "&appid=d16591c5f4f24840a17a76f78f3d0721"
    case appID = "&appid=439d4b804bc8187953eb36d2a8c26a02"
}

protocol WeatherLoaderDelegate {
    func loaded(_ weather: [Weather])
}

class WeatherLoader{
    
    var delegate: WeatherLoaderDelegate?
    var weatherForecast: [Weather] = []
    
    func loadWeatherStandartCurrent(){
        
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
        
        let urlString = Constant.URLCurrent.rawValue + Constant.appID.rawValue
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
}
