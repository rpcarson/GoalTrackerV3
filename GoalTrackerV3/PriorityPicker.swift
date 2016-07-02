//
//  PriorityPicker.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/27/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit

class PriorityPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    enum pickerOptions: Int {
        case High
        case Medium
        case Low
    }
    
    let options = ["High","Medium","Low"]
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return options[row]
    }
    
    func getCorrectRowForDisplay(pickerView: UIPickerView, goal: Goal) {
        let priority = goal.priority
        var index: Int
        switch priority {
            case "High": index = 0
            case "Medium": index = 1
            case "Low": index = 2
        default: index = 0
        }
        pickerView.selectRow(index, inComponent: 0, animated: false)
        
    }

}
