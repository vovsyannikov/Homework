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

enum Segments: String, CaseIterable{
    case comms = "Communication"
    case notifications = "Notifications"
    case general = "General"
}

struct Option{
    let icon: UIImage
    let name: String
    let type: OptionType
    
    var desc = ""
    
    let segment: Segments
}

class OptionsViewController: UIViewController {
    
    func countElementsInSection(opt: [Option], in section: Int) -> Int{
        var count = 0
        
        for el in opt{
            if section == 0{
                if el.segment == .comms {
                    count += 1
                }
            } else if section == 1{
                if el.segment == .notifications {
                    count += 1
                }
            } else if section == 2 {
                if el.segment == .general {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    var options = [
        Option(icon: UIImage(systemName: "airplane")!, name: "Авиарежим", type: .button, segment: .comms),
        Option(icon: UIImage(systemName: "wifi")!, name: "Wi-Fi", type: .standart, desc: "PublicNet", segment: .comms),
        Option(icon: UIImage(named: "bluetooth")!.withTintColor(UIColor.systemBlue), name: "Bluetooth", type: .standart, desc: "AirpodsPro", segment: .comms),
        Option(icon: UIImage(systemName: "antenna.radiowaves.left.and.right")!, name: "Сотовая связь", type: .standart, segment: .comms),
        Option(icon: UIImage(systemName: "link")!, name: "Режим можема", type: .standart, segment: .comms),
        Option(icon: UIImage(systemName: "app.badge.fill")!, name: "Уведомления", type: .standart, segment: .notifications),
        Option(icon: UIImage(systemName: "speaker.3.fill")!, name: "Звук, такитльные сигналы", type: .standart, segment: .notifications),
        Option(icon: UIImage(systemName: "moon.fill")!, name: "Не беспокоить", type: .standart, segment: .notifications),
        Option(icon: UIImage(systemName: "hourglass")!, name: "Экранное время", type: .standart, segment: .notifications),
        Option(icon: UIImage(systemName: "gear")!, name: "Основные", type: .standart, segment: .general),
        Option(icon: UIImage(systemName: "arrow.right.arrow.left")!, name: "Пункт управления", type: .standart, segment: .general),
        Option(icon: UIImage(systemName: "a.square.fill")!, name: "Экран и яркость", type: .standart, segment: .general)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        print()
    }

}

extension OptionsViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return Segments.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countElementsInSection(opt: options, in: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Spacer") as! OptionTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        func offset() -> Int{
            var count = 0
            for i in 0..<indexPath.section{
                count += countElementsInSection(opt: options, in: i)
            }
            
            return count + indexPath.row
        }
        let ID = options[indexPath.row].type
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ID.rawValue, for: indexPath) as! OptionTableViewCell
        cell.iconImageView.image = options[offset()].icon
        cell.nameLabel.text = options[offset()].name
            
        if ID == .standart{
            cell.descriptionLabel.text = options[offset()].desc
        }
        
        return cell
    }
    
    
}
