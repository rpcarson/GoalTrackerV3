//
//  DatePicker.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 7/1/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


extension UIDatePicker {
    
     func getDisplayDate(datePicker: UIDatePicker, goal: Goal) {
        let date = DateFormatter.dateFromString(goal.deadline)
        print("heres u rbad date \(date)")
        if let date = date {
             datePicker.setDate(date, animated: false)
        }
       
    }
    
}