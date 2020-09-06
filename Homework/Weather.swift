//
//  Weather.swift
//  Homework
//
//  Created by Виталий Овсянников on 06.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

let weatherConditions: [(en: String, ru: String)] = [
    (en: "Thunderstorm", ru: "Гроза"),
    (en: "Drizzle", ru: "Морось"),
    (en: "Rain", ru: "Дождь"),
    (en: "Snow", ru: "Снег"),
    (en: "Atmosphere", ru: "Туман"),
    (en: "Clear", ru: "Ясно"),
    (en: "Clouds", ru: "Облачно")]

struct MyDate{
    var day = 0
    var month = 0
    var year = 0_000
    
    var date = ""
    
    init(from dt: Date){
        var dateString = ""
        
        var index = 0
        for c in dt.description{
            if c != "-" && c != " " {
                dateString.append(c)
            } else {
                if index == 0{
                    self.year = Int(dateString)!
                    dateString = ""
                    index += 1
                } else if index == 1{
                    self.month = Int(dateString)!
                    dateString = ""
                    index += 1
                } else {
                    self.day = Int(dateString)!
                    dateString = ""
                    break
                }
            }
        }
        
        if self.day >= 10{
            self.date += "\(self.day)/"
        } else {
            self.date += "0\(self.day)/"
        }
        
        if self.month >= 10{
            self.date += "\(self.month)"
        } else {
            self.date += "0\(self.month)"
        }
        print (year, month, day, date)
    }
    
}

class Weather{
    
   

    let date: MyDate
    let temp: Int
    let main: String
    
    init?(data: NSDictionary) {
        guard let dt = data["dt"] as? Double,
        let temp = data["temp"] as? Double,
            let main = data["description"] as? String else {
                return nil
        }
        
        let simpleDate = Date(timeIntervalSince1970: dt + 10800)
        
        self.date = MyDate(from: simpleDate)
        self.temp = Int(temp)
        self.main = main
    }
    
   
}
