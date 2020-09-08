//
//  ViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 23.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

struct Anim{
    let names = [
        "Фон",
        "Перемещение",
        "Закругление краев",
        "Поворот",
        "Исчезновение",
        "Увеличение",
        "∞ поворот"
    ]
}

class ViewController: UIViewController {
    
    var currentAnim = 0

    @IBOutlet weak var testSubjectView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var anim = Anim()
        
        nameLabel.text = anim.names[currentAnim]
        numberLabel.text = "\(currentAnim + 1)"
    }

    @IBAction func nextAnimation(_ sender: Any) {
        if currentAnim == Anim().names.count - 1{
            currentAnim = 0
        } else {
            currentAnim += 1
        }
        viewDidLoad()
    }
    @IBAction func previousAnimation(_ sender: Any) {
        if currentAnim == 0{
            currentAnim = Anim().names.count - 1
        } else {
            currentAnim -= 1
        }
        viewDidLoad()
    }
    @IBAction func playAnimation(_ sender: Any) {
    }
    
}

