//
//  GoalViews.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation



protocol GoalTableViewController {
    var name: String { get set }
    var dateCreated: String { get set }
    var deadline: String { get set }
    var priority: String { get set }
    var dateCompleted: String? { get set }
}

protocol GoalDetailViewController: GoalTableViewController {
    var summary: String { get set }
    var type: String { get set }
    
}



protocol GoalViewNavBar {
    
    
}