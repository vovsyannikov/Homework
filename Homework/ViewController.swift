//
//  ViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 23.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var heightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changeLabelHeight(_ sender: Any) {
        
        if labelHeightConstraint.constant == 21 {
            labelHeightConstraint.constant = 21 * 5
            
            heightButton.setImage(UIImage.init(systemName: "chevron.up.square"), for: UIControl.State.normal)
        } else {
            labelHeightConstraint.constant = 21
            
            heightButton.setImage(UIImage.init(systemName: "chevron.down.square"), for: UIControl.State.normal)
        }
    }
    
}

