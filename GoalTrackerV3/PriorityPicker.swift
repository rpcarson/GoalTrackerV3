//
//  PriorityPicker.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/27/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit

class PriorityPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    enum pickerOptions: String {
        case High = "High"
        case Medium = "Medium"
        case Low = "Low"
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

}
