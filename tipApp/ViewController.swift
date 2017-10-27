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
        tipButton.isEnabled = true
        tipButton.isOpaque = false
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
        
        // Binds inputText and doubleTotal to optionals from the textField
        // and casting from String -> Double
        guard let inputText = totalField.text else {return}
        guard let doubleTotal = Double(inputText) else {return}
        
        // Formats the double from doubleTotal * 0.2 to two decimal places
        let tipValue = String(format: "%.2f", doubleTotal * 0.2)
        
        // Binds doubleTip to the casted string tipValue
        guard let doubleTip = Double(tipValue) else {return}
        
        // If the prompt is not hidden, this is executed
        if !prompt.isHidden {
            prompt.isHidden = true
            switchLabelStates()
        }
        
        // Sets the prompt to hidden so the above is never executed again
        prompt.isHidden = true
        
        // Sets the label values
        totalLabel.text = "Total: " + String(doubleTotal)
        tipAmount.text = "Tip Amount: " + tipValue
        newTotal.text =
            "New Total: " + String(format: "%.2f", doubleTotal + doubleTip)
        
    }
    
    func switchLabelStates() {
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

