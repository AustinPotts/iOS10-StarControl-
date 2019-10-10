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
        for newerLabel in 0..<componentCount {
            
            let starLabel = UILabel()
            starLabel.text = "★"
            starLabel.tag = newerLabel + 1
            starLabel.font = .systemFont(ofSize: 32, weight: .bold)
            starLabel.textAlignment = .center
            
            if starLabel.tag == 1 {
                starLabel.frame = CGRect(x: 8.0, y: 0, width: componentDimension, height: componentDimension)
                starLabel.alpha = 1
                starLabel.textColor = componentActiveColor
                
                //Set each label's frame to size componentDimension by componentDimension
            } else {
                starLabel.frame = CGRect(x: (componentDimension * CGFloat(newerLabel)) + 8.0, y: 0, width: componentDimension, height: componentDimension)
               starLabel.alpha = 0.4
                starLabel.textColor = componentInactiveColor
            }
            
            self.addSubview(starLabel)
            starLabels.append(starLabel)
        }
    }
    
    
}
