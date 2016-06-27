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
}

class TitleTextField: UITextField, UITextFieldDelegate {
    
    var displayDelegate: TitleTextFieldDisplayType?

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        displayDelegate?.textfieldDidReturn()
        return true
    }

}
