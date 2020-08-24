//
//  OptionsViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 24.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

enum OptionType: String{
    case standart = "Standart"
    case button = "Button"
}

struct Option{
    let icon: UIImage
    let name: String
    let type: OptionType
    
    var desc = ""
}

class OptionsViewController: UIViewController {
    
    let options = [
        Option(icon: UIImage(systemName: "airplane")!, name: "Авиарежим", type: .button),
        Option(icon: UIImage(systemName: "wifi")!, name: "Wi-Fi", type: .standart, desc: "PublicNet"),
        Option(icon: UIImage(named: "bluetooth")!, name: "Bluetooth", type: .standart, desc: "AirpodsPro"),
        Option(icon: UIImage(systemName: "antenna.radiowaves.left.and.right")!, name: "Сотовая связь", type: .standart),
        Option(icon: UIImage(systemName: "link")!, name: "Режим можема", type: .standart),
        Option(icon: UIImage(systemName: "app.badge.fill")!, name: "Уведомления", type: .standart),
        Option(icon: UIImage(systemName: "speaker.3.fill")!, name: "Звук, такитльные сигналы", type: .standart),
        Option(icon: UIImage(systemName: "moon.fill")!, name: "Не беспокоить", type: .standart),
        Option(icon: UIImage(systemName: "hourglass")!, name: "Экранное время", type: .standart),
        Option(icon: UIImage(systemName: "gear")!, name: "Основные", type: .standart),
        Option(icon: UIImage(systemName: "arrow.right.arrow.left")!, name: "Пункт управления", type: .standart),
        Option(icon: UIImage(systemName: "a.square.fill")!, name: "Экран и яркость", type: .standart)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}

extension OptionsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Standart", for: indexPath)
        
        return cell
    }
    
    
}
