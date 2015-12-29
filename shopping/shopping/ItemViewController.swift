//
//  ItemViewController.swift
//  shopping
//
//  Created by wayne.you on 15/8/11.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var brandNameLabel: UILabel!
    
    var item: Item?
    
    @IBAction func isBuy(sender: UIButton) {
        if item != nil {
            if item?.isBuy == false {
                item?.isBuy = true
                itemNameLabel.textColor = UIColor.greenColor()
            } else {
                item?.isBuy = false
                itemNameLabel.textColor = UIColor.redColor()
            }
            
            println(item?.description())
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if item != nil {
            itemNameLabel.text = item?.itemName
            brandNameLabel.text = item?.brandName
            println(item?.isBuy)
            println(item!.isBuy)
            if item!.isBuy {
                itemNameLabel.textColor = UIColor.greenColor()
            } else {
                itemNameLabel.textColor = UIColor.redColor()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
