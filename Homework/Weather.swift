//
//  Weather.swift
//  Homework
//
//  Created by Виталий Овсянников on 06.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class Weather{

    let date: Date
    let temp: Double
    let main: String
    
    init?(data: NSDictionary) {
        guard let date = data["dt"] as? Double,
        let temp = data["temp"] as? Double,
            let main = data["description"] as? String else {
                return nil
        }
        
        let dateDouble = Double(date)
        self.date = Date.init(timeIntervalSince1970: dateDouble)
        self.temp = temp
        self.main = main
    }
}
