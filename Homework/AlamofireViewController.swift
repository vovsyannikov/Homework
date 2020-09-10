//
//  AlamofireViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 05.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class AlamofireViewController: UIViewController {

    let weatherCell = WeatherTableViewCell()
    let wLoader = WeatherLoader()
    
    @IBOutlet weak var weatherTableView: UITableView!
    var weatherForecast: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wLoader.delegate = self
        // Загрузка погоды на день
//        wLoader.loadCurrentWeatherAlamofire()
        
        // Загрузка погоды на неделю
        wLoader.loadDialyWeatherAlamofire()
    }

}

extension AlamofireViewController: WeatherLoaderDelegate{
    func loaded(_ weather: [Weather]) {
        self.weatherForecast = weather
        weatherTableView.reloadData()
    }
}

extension AlamofireViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Current") as! WeatherTableViewCell
        
        let day = weatherForecast[indexPath.row]
        cell.tempLabel.text = String(day.temp) + " Cº"
        cell.descriptionLabel.text = day.main
        cell.dateLabel.text = day.dateString
        
        switch cell.descriptionLabel.text{
            
        case "Thunderstorm":
            cell.iconImageView.image = UIImage(systemName: "cloud.bolt.fill")
        case "Drizzle":
            cell.iconImageView.image = UIImage(systemName: "cloud.drizzle.fill")
        case "Rain":
            cell.iconImageView.image = UIImage(systemName: "cloud.rain.fill")
        case "Snow":
            cell.iconImageView.image = UIImage(systemName: "cloud.snow.fill")
        case "Atmosphere":
            cell.iconImageView.image = UIImage(systemName: "cloud.fog.fill")
        case "Clear":
            cell.iconImageView.image = UIImage(systemName: "sun.max.fill")
        case "Clouds":
            cell.iconImageView.image = UIImage(systemName: "cloud.fill")
            
        default: break
        }
        
        for el in weatherConditions {
            if cell.descriptionLabel.text == el.en {
                cell.descriptionLabel.text = el.ru
                break
            }
            
        }
        
        cell.iconImageView.tintColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
}
