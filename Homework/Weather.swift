//
//  Weather.swift
//  Homework
//
//  Created by Виталий Овсянников on 06.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit
import RealmSwift

// Переводчик
let weatherConditions: [(en: String, ru: String)] = [
    (en: "Thunderstorm", ru: "Гроза"),
    (en: "Drizzle", ru: "Морось"),
    (en: "Rain", ru: "Дождь"),
    (en: "Snow", ru: "Снег"),
    (en: "Atmosphere", ru: "Туман"),
    (en: "Clear", ru: "Ясно"),
    (en: "Clouds", ru: "Облачно")]

// Структура данных для собственного типа данных Дата
struct MyDate{
    var day = 00
    var month = 00
    var year = 0000
    
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
    }
    
    // Получение презентации даты. Для ближайщих двух дней: "Сегодня" и "Завтра", для отсальных дд/мм
    func getDate() -> String{
        var result = ""
        let currentDate = MyDate(from: Date(timeIntervalSinceNow: 10800))
        
        
        let dayDistance = self.day - currentDate.day
        let monthDistance = self.month - currentDate.month
        
        if dayDistance == 0 && monthDistance == 0{
            result = "Сегодня"
        } else if dayDistance == 1 {
            result = "Завтра"
        } else {
            if self.day >= 10{
                result += "\(self.day)/"
            } else {
                result += "0\(self.day)/"
            }
            
            if self.month >= 10{
                result += "\(self.month)"
            } else {
                result += "0\(self.month)"
            }
        }
        
        return result
    }
    
}

class Day: Object{
    var main = ""
    var temp = 0
    var date = ""
    
    func update(with weather: Weather){
        self.temp = weather.temp
        self.date = weather.dateString
        
        for dict in weatherConditions{
            if weather.main == dict.en{
                self.main = dict.ru
            }
        }
    }
}

class Weather{
    
    private let realm = try! Realm()
    
    let date: MyDate?
    var temp: Int = 0
    var main: String = ""
    var dateString = ""
    
    var days: [Day] = []
    
    init?(data: NSDictionary) {
        guard let dt = data["dt"] as? Double,
        let temp = data["temp"] as? Double,
            let main = data["description"] as? String else {
                return nil
        }
        
        // Создание константы с встроенным типом Date. Смезение в 10800 для установки часового пояса Москвы(+3 GMT)
        let simpleDate = Date(timeIntervalSince1970: dt + 10800)
        
        self.date = MyDate(from: simpleDate)
        self.temp = Int(temp)
        self.main = main
        self.dateString = date!.getDate()
    }
   
    
    func storeDays(for weatherForecast: [Weather]){
        for _ in weatherForecast{
            self.days.append(Day())
        }
        for (index,w) in weatherForecast.enumerated(){
            self.days[index].update(with: w)
            print("\(days[index].date) температура составит \(days[index].temp) Cº: \(days[index].main)")
        }
        
//        try! realm.write {
//            for d in days{
//                realm.add(d)
//            }
//        }
    }
}
