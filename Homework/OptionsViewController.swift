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
    
    func countElementsInSegment(opt: [Option]) -> Dictionary<Segments, Int> {
        var count: Dictionary<Segments, Int> = Dictionary()
        count[.comms] = 0
        count[.notifications] = 0
        count[.general] = 0
        
        for el in opt{
            switch el.segment {
            case .comms:
                count[.comms]! += 1
            case .notifications:
                count[.notifications]! += 1
            case .general:
                count[.general]! += 1
            }
        }
        
        return count
    }
}

class OptionsViewController: UIViewController {
    
    let options = [
        Option(icon: UIImage(systemName: "airplane")!, name: "Авиарежим", type: .button, segment: .comms),
        Option(icon: UIImage(systemName: "wifi")!, name: "Wi-Fi", type: .standart, desc: "PublicNet", segment: .comms),
        Option(icon: UIImage(named: "bluetooth")!, name: "Bluetooth", type: .standart, desc: "AirpodsPro", segment: .comms),
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
        
    }

}

extension OptionsViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return Segments.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = options[section].countElementsInSegment(opt: options)
        
        switch section {
        case 0: return sections[.comms]!
        case 1: return sections[.notifications]!
        case 2: return sections[.general]!
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = options[indexPath.row].type
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ID.rawValue, for: indexPath) as! OptionTableViewCell
        cell.iconImageView.image = options[indexPath.row].icon
        cell.nameLabel.text = options[indexPath.row].name
        
        if ID == .standart{
            cell.descriptionLabel.text = options[indexPath.row].desc
        }
        
        return cell
    }
    
    
}
