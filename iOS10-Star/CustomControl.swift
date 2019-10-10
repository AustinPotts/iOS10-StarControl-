//
//  CustomControl.swift
//  iOS10-Star
//
//  Created by Austin Potts on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class CustomControl: UIControl {
    
    var value = 1
    
    private let componentDimension: CGFloat = 40
    private let componentCount = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .gray
    
    //Local array
    private var starLabels: [UILabel] = []
    
    //Used when initializng from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    
    //This method tells Auto Layout how big your custom control should be
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    
    func setUp(){
        
        //use a loop to create five labels (using the UILabel() constructor). Add each one as a subview. Store each label into a local array with append.
        for newerStarLabel in 0..<componentCount {
            
            // create the label
            let starLabel = UILabel()
            starLabel.text = "🐙"
            starLabel.tag = newerStarLabel + 1
            starLabel.font = .systemFont(ofSize: 32, weight: .bold)
            starLabel.textAlignment = .center
            
            //add the tags to label
            if starLabel.tag == 1 {
                starLabel.frame = CGRect(x: 8.0, y: 0, width: componentDimension, height: componentDimension)
                starLabel.alpha = 1
                starLabel.textColor = componentActiveColor
                
                //Set each label's frame to size componentDimension by componentDimension
            } else {
                starLabel.frame = CGRect(x: (componentDimension * CGFloat(newerStarLabel)) + 8.0, y: 0, width: componentDimension, height: componentDimension)
               starLabel.alpha = 0.4
                starLabel.textColor = componentInactiveColor
            }
            
            self.addSubview(starLabel)
            starLabels.append(starLabel)
        }
    }
    
    //Update the value based upon touch point
    private func updateValue(at touch: UITouch) {
        
        //touch point set up
        let touchPoint = touch.location(in: self)
        
        //updating label + animation based on the touch point set
        for label in starLabels {
            if label.frame.contains(touchPoint) {
                if value != label.tag {
                    value = label.tag
                    updateLabels()
                    label.performFlare()
                    sendActions(for: [.valueChanged])
                }
            }
        }
    }
    
    private func updateLabels() {
        
        for starLabel in self.subviews {
            if let label = starLabel as? UILabel {
                if label.tag <= value {
                    label.alpha = 1
                    label.textColor = componentActiveColor
                } else {
                    label.alpha = 0.5
                    label.textColor = componentInactiveColor
                }
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchDragInside])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchDragOutside])
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        guard let touch = touch else { return }
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
    
}

//Animation for flare up
extension UIView {
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 2.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.5,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
