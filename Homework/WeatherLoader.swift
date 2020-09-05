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
    func loaded(weather: [Weather])
}

class WeatherLoader{
    var delegate: WeatherLoaderDelegate?
    
    func loadWeatherStandartCurrent(){
        let urlString = Constant.URLCurrent.rawValue + "&mode=json" + Constant.appID.rawValue
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
//                print(json)
            }
        }
        task.resume()
    }
}
