//
//  StandartViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 05.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class StandartViewController: UIViewController {
    
    let wLoader = WeatherLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherLoader().loadWeatherStandartCurrent()
    }
    

}
