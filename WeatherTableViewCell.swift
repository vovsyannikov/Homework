//
//  WeatherTableViewCell.swift
//  Homework
//
//  Created by Виталий Овсянников on 06.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
