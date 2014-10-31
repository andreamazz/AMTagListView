//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Andrea Mazzini on 31/10/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tagListView: AMTagListView!
    
    override func viewDidLoad() {
        
        self.title = "Demo"
        
        self.textField.layer.borderColor = UIColor(red:0.12, green:0.55, blue:0.84, alpha:1).CGColor
        self.textField.layer.borderWidth = 2.0
        self.textField.delegate = self
        AMTagView.appearance().tagLength = 10
        AMTagView.appearance().textPadding = 14
        AMTagView.appearance().textFont = UIFont(name: "Futura", size: 14)
        AMTagView.appearance().tagColor = UIColor(red:0.12, green:0.55, blue:0.84, alpha:1)
        
        self.tagListView.addTag("my tag")
        
        
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.tagListView.addTag(textField.text)
        self.textField.text = ""
        return false;
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.textField.resignFirstResponder()
    }
    
    
}

