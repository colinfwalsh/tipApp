//
//  ViewController.swift
//  tipApp
//
//  Created by Colin Walsh on 10/27/17.
//  Copyright © 2017 Colin Walsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newTotal: UILabel!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var totalField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipAmount.isHidden = true
        newTotal.isHidden = true
        totalField.delegate = self
        
        // Initializes a UITapGestureRecognizer with the selecter dismissKeyboard
        let tap = UITapGestureRecognizer.init(target: self, action:
            #selector(dismissKeyboard))
        
        // Adds the gesture recognizer to the view as a whole
        self.view.addGestureRecognizer(tap)
    }
    
    // Dismisses the keyboard when called
    @objc func dismissKeyboard() {
        totalField.resignFirstResponder()
    }
    
    // Does something when you hit the return key on the software keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return key pressed")
        totalField.resignFirstResponder()
        return false
    }
    
    // Can largely be ignored for our purposes
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When the Calculate Tip button is tapped, this is called
    @IBAction func calculateTip(_ sender: Any) {
    }
    
}

