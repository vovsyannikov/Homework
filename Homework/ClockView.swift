//
//  ClockView.swift
//  Homework
//
//  Created by Виталий Овсянников on 02.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

enum HandType{
    case hour
    case minute
    case second
}

@IBDesignable
class ClockView: UIView {
    
    var isDrawn = false
    
    let centerDot = UIView()
    
    // Отметки на циферблате для 12, 3, 6 и 9 часов
    private let markers: Dictionary<Int, UIView> = [12 : UIView(), 3 : UIView(), 6 : UIView(), 9 : UIView()]
    let markerColor = UIColor.blue
    
    // Стрелки
    private let hands: Dictionary<HandType, UIView> = [.hour : UIView(), .minute : UIView(), .second : UIView()]
    
    @IBInspectable var hourWidth: CGFloat = 4
    @IBInspectable var minuteWidth: CGFloat = 2
    @IBInspectable var secondWidth: CGFloat = 1
    
    @IBInspectable var hourOffset: CGFloat = 45
    @IBInspectable var minuteOffset: CGFloat = 30
    @IBInspectable var secondOffset: CGFloat = 25
    
    @IBInspectable var hourColor: UIColor = UIColor.black
    @IBInspectable var minuteColor: UIColor = UIColor.gray
    @IBInspectable var secondColor: UIColor = UIColor.red
    
    let markerWidth: CGFloat = 5
    let markerHeight: CGFloat = 20
    
    func drawMarkers(){
        
        let width = bounds.width
        let height = bounds.height
        
        markers[12]?.frame = CGRect(x: width/2 - markerWidth/2, y: 0, width: markerWidth, height: markerHeight)
        markers[3]?.frame = CGRect(x: width - markerHeight, y: height/2 - markerWidth/2, width: markerHeight, height: markerWidth)
        markers[6]?.frame = CGRect(x: width/2 - markerWidth/2, y: height-markerHeight, width: markerWidth, height: markerHeight)
        markers[9]?.frame = CGRect(x: 0, y: height/2 - markerWidth/2, width: markerHeight, height: markerWidth)
        
        for mark in markers.values{
            mark.backgroundColor = markerColor
        }
    }
    // Ломает всю систему
    func setTime(){
        for hand in hands.values{
            hand.transform = CGAffineTransform(rotationAngle: 2 *  CGFloat.pi)
        }

        let hour: CGFloat = 9
        let min: CGFloat = 41
        let sec: CGFloat = 0

        let angle: Dictionary<HandType, CGFloat> = [
            .hour   : CGFloat.pi * 2 * (hour/CGFloat(12)),
            .minute : CGFloat.pi * 2 * (min/CGFloat(60)),
            .second : CGFloat.pi * 2 * (sec/CGFloat(60))
        ]

        hands[.hour]?.transform = CGAffineTransform(rotationAngle: angle[.hour]!)
        hands[.minute]?.transform = CGAffineTransform(rotationAngle: angle[.minute]!)
        hands[.second]?.transform = CGAffineTransform(rotationAngle: angle[.second]!)
    }
    func drawHands(){
        
        for hand in [hands[.second]!, hands[.minute]!, hands[.hour]!]{
            hand.transform = .identity
            hand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
        
        let width = bounds.width
        let height = bounds.height
        
        
        let dotSize: CGFloat = 15
        
        centerDot.frame = CGRect(x: width/2 - dotSize/2, y: height/2 - dotSize/2, width: dotSize, height: dotSize)
        centerDot.backgroundColor = markerColor
        centerDot.layer.cornerRadius = dotSize/2
        
        
        hands[.hour]?.frame = CGRect(x: width/2 - hourWidth/2, y: hourOffset, width: hourWidth, height: height/2 - hourOffset)
        hands[.hour]?.backgroundColor = hourColor
        
        hands[.minute]?.frame = CGRect(x: width/2 - minuteWidth/2, y: minuteOffset, width: minuteWidth, height: height/2 - minuteOffset)
        hands[.minute]?.backgroundColor = minuteColor

        hands[.second]?.frame = CGRect(x: width/2 - secondWidth/2, y: secondOffset, width: secondWidth, height: height/2 - secondOffset)
        hands[.second]?.backgroundColor = secondColor
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        
        drawMarkers()
        drawHands()
        setTime()
        
        if isDrawn{ return }
        isDrawn = true
        
        for mark in markers.values{
            addSubview(mark)
        }
        for hand in hands.values{
            addSubview(hand)
        }
        addSubview(centerDot)
        
    }

}
