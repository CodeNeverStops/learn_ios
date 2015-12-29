//
//  NewItemViewController.swift
//  shopping
//
//  Created by wayne.you on 15/8/11.
//  Copyright (c) 2015年 lokizone. All rights reserved.
//

import UIKit

protocol NewItemViewControllerDelegate {
    func addNewItem(controller: NewItemViewController, item: Item)
}

class NewItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var brandNameTextField: UITextField!
    
    var item: Item?
    var delegate: NewItemViewControllerDelegate! = nil
    
    @IBAction func saveItem(sender: UIButton) {
        if itemNameTextField.text != nil && brandNameTextField.text != nil {
            item = Item(itemName: itemNameTextField.text, brandName: brandNameTextField.text)
        }
        println(item?.description())
        println(delegate)
        delegate.addNewItem(self, item: item!)
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

