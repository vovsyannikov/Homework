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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changeLabelHeight(_ sender: Any) {
        labelHeightConstraint.constant += labelHeightConstraint.constant * 5
    }
    
}

