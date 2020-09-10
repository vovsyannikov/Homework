//
//  UserDefaultsViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit
import RealmSwift

class Person: Object{
    @objc dynamic var firstName = ""
    @objc dynamic var secondName = ""
}

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var changeNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainLabel.text = "Приветствую, введите свое имя"
        
        changeNameButton.layer.borderWidth = 0.75
        changeNameButton.layer.borderColor = UIColor.blue.cgColor
        changeNameButton.layer.cornerRadius = CGFloat(10)
        changeNameButton.titleLabel?.textColor = UIColor.blue
        
    }
    @IBAction func changeMainLabel(_ sender: Any) {
    }
    
}
