//
//  ViewController.swift
//  tipApp
//
//  Created by Colin Walsh on 10/27/17.
//  Copyright © 2017 Colin Walsh. All rights reserved.
//

import UIKit

enum InputError: Error {
    case notValid(String)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var prompt: UILabel!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var newTotal: UILabel!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        switchLabelStates()
        
        // Allows us to use custom methods to control the input field
        totalField.delegate = self
        
        // Only allows a user to type numbers and .
        totalField.keyboardType = .decimalPad
        
        // We don't want users to enter empty values, so we disable the calculate
        // button until a user starts typing in the input field
        tipButton.isEnabled = false
        tipButton.isOpaque = true
        
        // Automatically clears all values in the input field whenever a user taps
        // on it
        totalField.clearsOnBeginEditing = true
        
        // Initializes a UITapGestureRecognizer with the selecter dismissKeyboard
        let tap = UITapGestureRecognizer.init(target: self, action:
            #selector(dismissKeyboard))

        // Adds the gesture recognizer to the view as a whole
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let lineColor = UIColor(red:0.12, green:0.23, blue:0.35, alpha:1.0)
        totalField.setBottomLine(borderColor: lineColor)
    }
    
    // Dismisses the keyboard when called
    @objc func dismissKeyboard() {
        totalField.resignFirstResponder()
    }
    
    // Only allows characters from 0-9 and ., shouldn't be an issue with the
    // decimal keyboard, but just in case
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    // Can largely be ignored for our purposes
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // When the Calculate Tip button is tapped, this is called
    @IBAction func calculateTip(_ sender: Any) {
        
        /* Implement this method */
        
    }
    
    func switchLabelStates() {
        // Helpful to switch states for the labels
        
        totalLabel.isHidden = !totalLabel.isHidden
        tipAmount.isHidden = !tipAmount.isHidden
        newTotal.isHidden = !newTotal.isHidden
    }
    
}

extension UITextField {
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 3.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
}

