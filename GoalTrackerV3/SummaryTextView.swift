//
//  SummaryTextView.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit
import QuartzCore

class SummaryTextView: UITextView, UITextViewDelegate {
    
    override func drawRect(rect: CGRect) {
        
        layer.cornerRadius = 8
    }
    
    let placeholderText = "Add a summary for your goal"
    
    func clearText() {
        if self.text == placeholderText {
            self.text = ""
        }
        
    }
    

    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("IS EDITING")
        clearText()
        
        return true
    }
    
    
}
