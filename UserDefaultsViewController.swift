//
//  UserDefaultsViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class Person{
    var firstName = ""
    var secondName = ""
}

class UserDefaultsViewController: UIViewController {
    
    let person = Person()

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var changeNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = "Приветствую"
        
        
        changeNameButton.layer.borderWidth = 0.75
        changeNameButton.layer.borderColor = UIColor.blue.cgColor
        changeNameButton.layer.cornerRadius = CGFloat(10)
        changeNameButton.titleLabel?.textColor = UIColor.blue
        
        
    }
    @IBAction func changeMainLabel(_ sender: Any) {
        self.person.firstName = firstNameTextField.text!
        self.person.secondName = secondNameTextField.text!
        
        mainLabel.text = "Приветствую \(person.firstName) \(person.secondName)"
    }
    
}
