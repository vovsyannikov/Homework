//
//  TodoListTableViewCell.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
