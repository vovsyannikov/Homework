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
    case cornerRadius
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
    @IBOutlet weak var prevAnimButton: UIButton!
    @IBOutlet weak var nextAnimButton: UIButton!
    
    func setLabels(){
        nameLabel.text = names[currentAnim]
        numberLabel.text = "\(currentAnim + 1)"
    }
    
    var defaultColor = UIColor()
    var defaultRect = CGRect()
    var isCircle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testSubjectView.backgroundColor = UIColor.red
        defaultColor = testSubjectView.backgroundColor!
        defaultRect = CGRect(x: view.bounds.width/2 - self.testSubjectView.frame.width/2, y: view.bounds.height/2 - self.testSubjectView.frame.height/2, width: self.testSubjectView.frame.width, height: self.testSubjectView.frame.height)
        
        setLabels()
    }
    
    func playAnim(){
        func backgroundColorChange(){
            self.testSubjectView.layer.removeAllAnimations()
            self.nextAnimButton.isEnabled.toggle()
            self.prevAnimButton.isEnabled.toggle()
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.testSubjectView.backgroundColor = UIColor.yellow
            }) { isFinished in
                self.testSubjectView.backgroundColor = UIColor.red
                
                self.nextAnimButton.isEnabled.toggle()
                self.prevAnimButton.isEnabled.toggle()
            }
        }
        func moveToUpperRightCorner(){
            self.nextAnimButton.isEnabled.toggle()
            self.prevAnimButton.isEnabled.toggle()
            self.testSubjectView.frame = self.defaultRect
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                    self.testSubjectView.frame = CGRect(x: self.view.bounds.width - self.testSubjectView.frame.size.width, y: 0, width: self.testSubjectView.frame.size.width, height: self.testSubjectView.frame.size.height)
                }) { isFinished in
                    self.testSubjectView.frame = self.defaultRect
                    
                    self.nextAnimButton.isEnabled.toggle()
                    self.prevAnimButton.isEnabled.toggle()
                }
            }
            
        }
        func cornerRaduisChange(){
            self.nextAnimButton.isEnabled.toggle()
            self.prevAnimButton.isEnabled.toggle()
            func toCircle(){
                let animationType = (name: Constant.cornerRadius.rawValue, value: self.testSubjectView.frame.size.width/2)
                let animation = CABasicAnimation(keyPath: animationType.name)
                animation.fromValue = NSNumber(value: 0)
                animation.toValue = NSNumber(value: Float(animationType.value))
                animation.duration = 2.0
                testSubjectView.layer.add(animation, forKey: animationType.name)
                testSubjectView.layer.cornerRadius = animationType.value
            }
            func fromCircle(){
                let animationType = (name: Constant.cornerRadius.rawValue, value: self.testSubjectView.frame.size.width/2)
                let animation = CABasicAnimation(keyPath: animationType.name)
                animation.fromValue = NSNumber(value: Float(animationType.value))
                animation.toValue = NSNumber(value: 0)
                animation.duration = 2.0
                testSubjectView.layer.add(animation, forKey: animationType.name)
                testSubjectView.layer.cornerRadius = 0
            }
            
            
            // Для ручной работы
//            switch isCircle{
//            case false: toCircle()
//            case true: fromCircle()
//            }
//            isCircle.toggle()
            
            
//             Для автоматической работы
            toCircle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.15) {
                fromCircle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.nextAnimButton.isEnabled.toggle()
                    self.prevAnimButton.isEnabled.toggle()
                }
            }
        }
        func rotate(){
            self.nextAnimButton.isEnabled.toggle()
            self.prevAnimButton.isEnabled.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                    self.testSubjectView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }) { isFinished in
                    self.testSubjectView.transform =  CGAffineTransform(rotationAngle: CGFloat(0))
                    self.nextAnimButton.isEnabled.toggle()
                    self.prevAnimButton.isEnabled.toggle()
                }
            }
        }
        func changeAlpha(){
            self.nextAnimButton.isEnabled.toggle()
            self.prevAnimButton.isEnabled.toggle()
            self.testSubjectView.alpha = 1
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.testSubjectView.alpha = 0
            }) { isFinished in
                self.testSubjectView.alpha = 1
                
                self.nextAnimButton.isEnabled.toggle()
                self.prevAnimButton.isEnabled.toggle()

            }
        }
        func scale(){
            self.nextAnimButton.isEnabled.toggle()
            self.prevAnimButton.isEnabled.toggle()
            self.testSubjectView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            UIView.animate(withDuration: 2, delay: 0, options: .autoreverse, animations: {
                self.testSubjectView.transform = CGAffineTransform(scaleX: 2, y: 2)
            }) { isFinished in
                self.testSubjectView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.nextAnimButton.isEnabled.toggle()
                self.prevAnimButton.isEnabled.toggle()

            }
        }
        func infiniteRotation(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear, .repeat], animations: {
                    self.testSubjectView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                }) {isFinished in
                    
                }
            }
            
        }
        
        
        switch currentAnim{
        case 0: backgroundColorChange()
        case 1: moveToUpperRightCorner()
        case 2: cornerRaduisChange()
        case 3: rotate()
        case 4: changeAlpha()
        case 5: scale()
        case 6: infiniteRotation()
        default: break
        }
    }
    
    

    @IBAction func nextAnimation(_ sender: Any) {
        
        if currentAnim == names.count - 1{
            currentAnim = 0
        } else {
            currentAnim += 1
        }
        
        setLabels()
        playAnim()
    }
    @IBAction func previousAnimation(_ sender: Any) {
        
        if currentAnim == 0{
            currentAnim = names.count - 1
        } else {
            currentAnim -= 1
        }
        
        setLabels()
        playAnim()
    }
    @IBAction func playAnimation(_ sender: Any) {
        playAnim()
    }
    
}

