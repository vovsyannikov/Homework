//
//  ViewController.swift
//  Homework
//
//  Created by Виталий Овсянников on 23.08.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

enum Constant: String{
    case top
    case trailing
}

class ViewController: UIViewController {
    
    var currentAnim = 0
    let names = [
        "Фон",
        "Перемещение",
        "Закругление краев",
        "Поворот",
        "Исчезновение",
        "Увеличение",
        "∞ поворот"
    ]

    @IBOutlet weak var testSubjectView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var defaultColor = UIColor()
    var defaultRect = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testSubjectView.backgroundColor = UIColor.red
        defaultColor = testSubjectView.backgroundColor!
        defaultRect = CGRect(x: view.bounds.width/2 - self.testSubjectView.frame.width/2, y: view.bounds.height/2 - self.testSubjectView.frame.height/2, width: self.testSubjectView.frame.width, height: self.testSubjectView.frame.height)
        
        
        nameLabel.text = names[currentAnim]
        numberLabel.text = "\(currentAnim + 1)"
    }
    
    func playAnim(){
        func backgroundColorChange(){
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.testSubjectView.backgroundColor = UIColor.yellow
            }) { isFinished in
                self.testSubjectView.backgroundColor = UIColor.red
            }
        }
        func moveToUpperRightCorner(){
            UIView.animateKeyframes(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.testSubjectView.frame = CGRect(x: self.view.bounds.width - self.defaultRect.width, y: 0, width: self.defaultRect.width, height: self.defaultRect.height)
                self.view.layoutIfNeeded()
            }) { isFinished in
                self.testSubjectView.frame = self.defaultRect
                self.view.layoutIfNeeded()
            }
        }
        
        
        moveToUpperRightCorner()
    }

    @IBAction func nextAnimation(_ sender: Any) {
        if currentAnim == names.count - 1{
            currentAnim = 0
        } else {
            currentAnim += 1
        }
        viewDidLoad()
    }
    @IBAction func previousAnimation(_ sender: Any) {
        if currentAnim == 0{
            currentAnim = names.count - 1
        } else {
            currentAnim -= 1
        }
        viewDidLoad()
    }
    @IBAction func playAnimation(_ sender: Any) {
        playAnim()
    }
    
}

