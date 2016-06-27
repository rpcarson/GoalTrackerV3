//
//  EditViewController.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/24/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, TitleTextFieldDisplayType {
    
    @IBOutlet weak var nameButtonTitle: UIButton!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var nameTextField: TitleTextField!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var priorityPicker: PriorityPicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    func configureDatePicker() {
        datePicker.datePickerMode = .Date
    }
    
    
    func configurePriorityPicker() {
        priorityPicker.delegate = priorityPicker
        priorityPicker.dataSource = priorityPicker
    }
    
    var isEditable: Bool = true
    var selectedGoal: Goal?
    
    //MARK: - Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configurePriorityPicker()
        configureDatePicker()
        
        print(priorityPicker.numberOfComponents)
        print(priorityPicker.numberOfRowsInComponent(0))
    }
    
    override func viewWillAppear(animated: Bool) {
        if isEditable {
            initalCreationSetup()
        } else {
            loadExistingGoal(selectedGoal!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if nameTextField.isFirstResponder() {
            textfieldDidReturn()
        }
        if summaryTextView.isFirstResponder() {
            summaryTextView.resignFirstResponder()
        }
        
    }

    
    func saveGoal() {
        let name = nameButtonTitle.titleLabel!.text!
        let dateCreated = dateCreatedLabel.text!
        let summary = summaryTextView.text
        let priority = priorityPicker.options[priorityPicker.selectedRowInComponent(0)]
        let deadline = DateFormatter.datePickerToString(datePicker.date)
        
        let goal = Goal(name: name, dateCreated: dateCreated, summary: summary, type: "Placeholder Type", priority: priority, deadline: deadline, dateCompleted: "Placeholder Completed")
        
        DataManager.saveGoalToCD(goal)
    }
    
    func doneButton() {
        saveGoal()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: - TextFieldConfig
    
    @IBAction func showTextField() {
        if !isEditable { return }
        nameButtonTitle.hidden = true
        nameTextField.hidden = false
        nameTextField.becomeFirstResponder()
    }
    
    func textfieldDidReturn() {
        nameTextField.hidden = true
        nameButtonTitle.hidden = false
        nameTextField.resignFirstResponder()
        nameButtonTitle.setTitle(nameTextField.text, forState: .Normal)
    }
    
    //MARK: - CONfig UI
    
    func configureUI() {
        nameTextField.hidden = true
        nameTextField.delegate = nameTextField
        nameTextField.displayDelegate = self
        nameButtonTitle.tintColor = UIColor.blackColor()
        
        if isEditable {
            let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(EditViewController.doneButton))
            navigationItem.setRightBarButtonItem(doneButton, animated: true)
            navigationItem.title = "Edit Goal"
        }
        if !isEditable {
            nameButtonTitle.userInteractionEnabled = false
            summaryTextView.userInteractionEnabled = false
        }
    }

    func initalCreationSetup() {
        dateCreatedLabel.text = DateFormatter.convertToString(NSDate())
    }
    
    
    func loadExistingGoal(goal: Goal) {
        //print("existing goal loaded \(goal)")
        nameButtonTitle.setTitle(goal.name, forState: .Normal)
        dateCreatedLabel.text = goal.dateCreated
        summaryTextView.text = goal.summary
    }

    //TODO: - keyboard pushes up textview

}
