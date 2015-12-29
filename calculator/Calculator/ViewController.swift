//
//  ViewController.swift
//  Calculator
//
//  Created by Wayne on 15/7/10.
//  Copyright (c) 2015年 Wayne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isUserTyping: Bool = false

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
            isUserTyping = true
        }
    }
    
}

