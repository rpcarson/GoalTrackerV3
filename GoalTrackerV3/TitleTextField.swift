//
//  TitleTextField.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit

protocol TitleTextFieldDisplayType {
    func textfieldDidReturn()
    func invalidFieldWarning()
    func textFieldBeganEditing()
}

class TitleTextField: UITextField, UITextFieldDelegate {
    
    let alert = TextFieldAlert()
    
    var invalidField: Bool = false
    
    let placeholderText = "Tap to name your goal"
    
    var displayDelegate: TitleTextFieldDisplayType?
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        displayDelegate?.textFieldBeganEditing()

    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.text == "" {
            displayDelegate?.invalidFieldWarning()
            textField.text = placeholderText
        }
        displayDelegate?.textfieldDidReturn()

            return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        displayDelegate?.textfieldDidReturn()
        return true
    }

}
