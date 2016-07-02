//
//  InProgressTableViewController.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit
import CoreData

class InProgressTableViewController: UITableViewController {
    
    var currentTabIndex: Int?
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    func configureNavBar() {
        let addButton =  UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(InProgressTableViewController.showEditView))
        navigationItem.setRightBarButtonItem(addButton, animated: true)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        
        currentTabIndex = self.tabBarController?.selectedIndex

    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        print("InProgressTableView will appear")
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.goalsObjects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("inProgessGoalCell", forIndexPath: indexPath) as! InProgressGoalCell
        
        let object = appDelegate.goalsObjects[indexPath.row]
        let goal = DataManager.convertManagedObjectToGoal(object)
        
        cell.dateCreated.text = goal.dateCreated
        cell.name.text = goal.name
        cell.backgroundColor = goal.priorityColor

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let goal = DataManager.convertManagedObjectToGoal(appDelegate.goalsObjects[indexPath.row])
        showDetailView(forGoal: goal, withIndex: indexPath.row)
    }
 
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let object = appDelegate.goalsObjects[indexPath.row]
            appDelegate.goalsObjects.removeAtIndex(indexPath.row)
            DataManager.deleteObjectFromCoreData(object)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showEditView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC: EditViewController = storyboard.instantiateViewControllerWithIdentifier("editViewController") as! EditViewController
        editVC.hidesBottomBarWhenPushed = true
        editVC.isEditable = true
        editVC.isNewGoal = true
        navigationController?.pushViewController(editVC, animated: true)
    }
    func showDetailView(forGoal goal: Goal, withIndex: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewControllerWithIdentifier("editViewController") as! EditViewController
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.isEditable = false
        detailVC.selectedGoal = goal
        detailVC.isNewGoal = false
        detailVC.goalIndex = withIndex
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
