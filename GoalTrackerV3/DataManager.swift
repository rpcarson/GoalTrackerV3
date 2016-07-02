//
//  DataManager.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/25/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct DataManager {
    
    static func deleteObjectFromCoreData(object: NSManagedObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        context.deleteObject(object)
        do {
            try context.save()
        } catch let error as NSError {
            print("trouble deleting object form context")
        }
        
    }
    
    static func saveGoalToCD(goal: Goal) {
        
        print("saving goal")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entityForName("Goal", inManagedObjectContext: managedContext)
        let goalObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        goalObject.setValue(goal.name, forKey: "name")
        goalObject.setValue(goal.dateCreated, forKey: "dateCreated")
        goalObject.setValue(goal.summary, forKey: "summary")
        goalObject.setValue(goal.priority, forKey: "priority")
        goalObject.setValue(goal.type, forKey: "type")
        goalObject.setValue(goal.deadline, forKey: "deadline")
        if let dateCompleted = goal.dateCompleted {
            goalObject.setValue(dateCompleted, forKey: "dateCompleted")
        }
        
        do {
            try managedContext.save()
            appDelegate.goalsObjects.append(goalObject)
            
            print("--------save goal \(goal) successful------")
            
        } catch let error as NSError {
            print("saving goalObject \(goalObject) failed with error: \(error),\(error.userInfo))")
        }
        
        
    }
    
    static func updateGoal(goalIndex: Int, summary: String?, priority: String?, deadline: String?) {
        
        print("updating goal \(goalIndex))")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let goalObject = appDelegate.goalsObjects[goalIndex]
        if let summary = summary {
            goalObject.setValue(summary, forKey: "summary")
        }
        if let priority = priority {
            goalObject.setValue(priority, forKey: "priority")
        }
        if let deadline = deadline {
            goalObject.setValue(deadline, forKey: "deadline")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("u fucked up updating this goal")
        }
        
    }
    
    static func fetchGoalData() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Goal")
        
        do {
            let data = try managedContext.executeFetchRequest(fetchRequest)
            appDelegate.goalsObjects = data as! [NSManagedObject]
            
            print("--------fetch data successful------")
            
        } catch let error as NSError {
            print("fetch data failed \(error), \(error.userInfo))")
        }
        
        
        
    }
    
    static func convertManagedObjectToGoal(object: NSManagedObject) -> Goal {
        
        let name = object.valueForKey("name") as! String
        let dateCreated = object.valueForKey("dateCreated") as! String
        let summary = object.valueForKey("summary") as! String
        let type = object.valueForKey("type") as! String
        let priority = object.valueForKey("priority") as! String
        let deadline = object.valueForKey("deadline") as! String
        var dateCompleted: String? {
            return object.valueForKey("dateCompleted") as? String
        }
        
        let goal = Goal(name: name, dateCreated: dateCreated, summary: summary, type: type, priority: priority, deadline: deadline, dateCompleted: dateCompleted)
        
        print(" object converted to goal: \(goal.name)")
        
        
        return goal
        
    }
}

