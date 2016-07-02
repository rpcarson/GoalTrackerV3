//
//  DateFormatter.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation


class DateFormatter {
    static func convertToString(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .LongStyle
        
        return formatter.stringFromDate(date)
        
    }
    static func datePickerToString(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.stringFromDate(date)
    }
    
    static func dateFromString(string: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateStyle = .LongStyle
        
        if let date = formatter.dateFromString(string) {
            return date
        }
        return nil
    }
    
    enum TimeRemainingOpions {
        case Days
        case Minutes
    }
   
    static func getTimeRemainingIn(startDate: NSDate, deadline: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let days = calendar.components(.Day, fromDate: startDate, toDate: deadline, options: [])
        
        return days.day
    }
    static func getMonthAndDay(date: NSDate) {
        
    }
}