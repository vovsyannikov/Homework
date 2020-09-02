//
//  RandomButton.swift
//  Homework
//
//  Created by Виталий Овсянников on 02.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit


@IBDesignable
class RandomButton: UIView {
    
    var isDrawn = false

    private let button: UIButton = UIButton()
    
    @IBInspectable var borderColor: UIColor = UIColor.red
    @IBInspectable var width: CGFloat = 50
    @IBInspectable var cornerRadius: CGFloat = 0
    
    
    func createButton(){
        
        button.frame = CGRect(x: bounds.width/2 - width/2, y: 0, width: width, height: bounds.height)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = cornerRadius
        button.layer.borderColor = borderColor.cgColor
        button.setTitle("Hello", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.createButton()
        
        if isDrawn{return}
        isDrawn = true

        addSubview(button)
        
    }

}
