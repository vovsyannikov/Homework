//
//  SegmentsView.swift
//  Homework
//
//  Created by Виталий Овсянников on 02.09.2020.
//  Copyright © 2020 Виталий Овсянников. All rights reserved.
//

import UIKit

protocol SegmentsViewDelegate {
    func getSelectedSegment(_ selectedSegment: Int)
}

@IBDesignable
class SegmentsView: UIView {
    
    var delegate: SegmentsViewDelegate?
    
    var isDrawn = false

    private let segmentView = UISegmentedControl()
    @IBInspectable var firstTitle: String = "First"
    @IBInspectable var secondTitle: String = "Second"
    @IBInspectable var selectedSegmentColor: UIColor = UIColor.blue
    @IBInspectable var backColor: UIColor = UIColor.systemGray6
    
    func createSegmentView(){
        segmentView.insertSegment(withTitle: firstTitle, at: 0, animated: false)
        segmentView.insertSegment(withTitle: secondTitle, at: 1, animated: false)
        segmentView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        segmentView.selectedSegmentIndex = 0
        segmentView.selectedSegmentTintColor = selectedSegmentColor
        segmentView.backgroundColor = backColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createSegmentView()
        
        delegate?.getSelectedSegment(segmentView.selectedSegmentIndex)
        
        if isDrawn{return}
        isDrawn = true
        
        addSubview(segmentView)
        
    }

}
