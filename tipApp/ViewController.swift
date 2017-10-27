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
    
    @IBOutlet weak var tipField: UITextField!
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
        
        tipField.delegate = self
        tipField.keyboardType = .decimalPad
        
        tipField.attributedPlaceholder = NSAttributedString(string: "Tip",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        
        totalField.attributedPlaceholder = NSAttributedString(string: "Bill",
                                                              attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.6)])
        
        let tipPercentLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        tipPercentLabel.text = "%"
        tipPercentLabel.textColor = .white
        tipField.leftView = tipPercentLabel
        tipField.leftViewMode = UITextFieldViewMode.always
        
        let dollarSignLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        dollarSignLabel.text = "$"
        dollarSignLabel.textColor = .white
        totalField.leftView = dollarSignLabel
        totalField.leftViewMode = UITextFieldViewMode.always
        
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
        tipField.setBottomLine(borderColor: lineColor)
    }
    
    // Dismisses the keyboard when called
    @objc func dismissKeyboard() {
        tipButton.isEnabled = true
        tipButton.isOpaque = false
        
        tipField.resignFirstResponder()
        totalField.resignFirstResponder()
    }
    
    // Only allows characters from 0-9 and ., shouldn't be an issue with the
    // decimal keyboard, but just in case
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789.").inverted
        
        if textField == totalField {
            return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
            
        } else {
            guard let text = textField.text else {return true}
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 2 // Bool
        }
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

