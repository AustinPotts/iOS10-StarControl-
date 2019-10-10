//
//  ViewController.swift
//  iOS10-Star
//
//  Created by Austin Potts on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        
        
        
        //take the rating controls value & see if it equals one, is so make the title string non plural
        if ratingControl.value == 1 {
            navigationItem.title = "DONT MAKE ME INK! - 1 Ink"
        //else if the value is more than one star, add plural to the rating controls value
        } else {
            navigationItem.title = "YOU GUYS MADE ME INK🥺  \(ratingControl.value) Inks Made"
        }
        
    }
    
}

