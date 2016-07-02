//
//  Goal.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


enum GoalType: String {
    case ShortTerm = "ShortTerm"
    case LongTerm = "LongTerm"
}

enum PriorityLevel: String {
    case Low = "Low"
    case Medium = "Medium"
    case High = "High"
}

struct Goal {
    
    var priorityColor: UIColor {
        switch priority {
        case "High": return .redColor()
        case "Medium": return .yellowColor()
        case "Low": return .greenColor()
        default: return .whiteColor()
        }
    }
    
    var nsDateCreated: NSDate {
        return DateFormatter.dateFromString(dateCreated)!
    }
    
    
    
    
    
    var name: String
    var dateCreated: String
    var summary: String
    var type: String
    var priority: String
    var deadline: String
    var dateCompleted: String?
    

    
}