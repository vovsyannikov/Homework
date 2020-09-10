//
//  UserDefaultsViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 10.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

class Person{
    static let shared = Person()
    
    private let kFirstNameKey = "Person.kFirstNameKey"
    private let kSecondNameKey = "Person.kSecondNameKey"
    var firstName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kFirstNameKey)}
        get { return UserDefaults.standard.string(forKey: kFirstNameKey)}
    }
    var secondName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kSecondNameKey)}
        get { return UserDefaults.standard.string(forKey: kSecondNameKey)}
    }
}

class UserDefaultsViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var changeNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainLabel.text = "Приветствую \(Person.shared.firstName!) \(Person.shared.secondName!)"
        
        changeNameButton.layer.borderWidth = 0.75
        changeNameButton.layer.borderColor = UIColor.blue.cgColor
        changeNameButton.layer.cornerRadius = CGFloat(10)
        changeNameButton.titleLabel?.textColor = UIColor.blue
        
        
    }
    @IBAction func changeMainLabel(_ sender: Any) {
        Person.shared.firstName = firstNameTextField.text!
        Person.shared.secondName = secondNameTextField.text!
        
        mainLabel.text = "Приветствую \(Person.shared.firstName!) \(Person.shared.secondName!)"
    }
    
}
