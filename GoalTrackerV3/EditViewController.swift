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
    @IBOutlet weak var summaryTextView: SummaryTextView!
    @IBOutlet weak var priorityPicker: PriorityPicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var isEditable: Bool = true
    var selectedGoal: Goal?
    var goalIndex: Int?
    var isNewGoal: Bool = true
    let textFieldAlert = TextFieldAlert()
    
    //MARK: - Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
        
        summaryTextView.delegate = summaryTextView
        nameTextField.delegate = nameTextField
        priorityPicker.delegate = priorityPicker
        priorityPicker.dataSource = priorityPicker
        nameTextField.displayDelegate = self


    }
    
    override func viewWillAppear(animated: Bool) {
        setupNavBar()
        if isEditable {
            initialCreationSetup()
        } else {
            loadExistingGoal(selectedGoal!)
        }
        nameButtonTitle.userInteractionEnabled = isNewGoal ? true : false
        summaryTextView.userInteractionEnabled = isEditable ? true : false
        datePicker.userInteractionEnabled = isEditable ? true : false
        priorityPicker.userInteractionEnabled = isEditable ? true : false
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
        
        print(goalIndex)
        let name = nameButtonTitle.titleLabel!.text!
        let dateCreated = dateCreatedLabel.text!
        let summary = summaryTextView.text
        let priority = priorityPicker.options[priorityPicker.selectedRowInComponent(0)]
        let deadline = DateFormatter.datePickerToString(datePicker.date)
        
        if isNewGoal {
            let goal = Goal(name: name, dateCreated: dateCreated, summary: summary, type: "Placeholder Type", priority: priority, deadline: deadline, dateCompleted: "Placeholder Completed")
            DataManager.saveGoalToCD(goal)
        } else {
            DataManager.updateGoal(goalIndex!, summary: summary, priority: priority, deadline: deadline)
        }
        
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
        if !nameTextField.invalidField {
            nameButtonTitle.setTitle(nameTextField.text, forState: .Normal)
        } else {
            nameButtonTitle.setTitle(nameTextField.placeholderText, forState: .Normal)
        }
        nameTextField.hidden = true
        nameButtonTitle.hidden = false
        nameTextField.resignFirstResponder()
    }
    
    func invalidFieldWarning() {
        nameButtonTitle.titleLabel?.text = nameTextField.placeholderText
        nameTextField.hidden = true
        nameButtonTitle.hidden = false
        textFieldAlert.presentAlert(self)
    }
    //prevents former button title from breifly flashing before text is changed by textfield
    func textFieldBeganEditing() {
        print("began editing")
        if nameTextField.text == nameTextField.placeholderText {
            nameTextField.text = ""
        }
        
       // nameButtonTitle.setTitle("", forState: .Normal)
    }
    
    //MARK: - CONfig UI
    
    func configureUI() {
        view.backgroundColor = UIColor(red:0.63, green:1, blue:0.85, alpha:1)
        datePicker.datePickerMode = .Date
        nameTextField.hidden = true
        nameButtonTitle.tintColor = UIColor.blackColor()
        
        setupNavBar()
    }
    
    //MARK: - Editable/NonEditable Properties

    func initialCreationSetup() {
        dateCreatedLabel.text = DateFormatter.convertToString(NSDate())
        summaryTextView.text = summaryTextView.placeholderText
        nameTextField.text = nameTextField.placeholderText
        nameButtonTitle.setTitle(nameTextField.placeholderText, forState: .Normal)
    }
    
    func loadExistingGoal(goal: Goal) {
        nameButtonTitle.setTitle(goal.name, forState: .Normal)
        dateCreatedLabel.text = goal.dateCreated
        summaryTextView.text = goal.summary
        priorityPicker.getCorrectRowForDisplay(priorityPicker, goal: selectedGoal!)
        datePicker.getDisplayDate(datePicker, goal: selectedGoal!)
    }
    
    func toggleEditable() {
        isEditable = isEditable ? false : true
        //nameButtonTitle.userInteractionEnabled = isEditable ? true : false
        summaryTextView.userInteractionEnabled = isEditable ? true : false
        datePicker.userInteractionEnabled = isEditable ? true : false
        priorityPicker.userInteractionEnabled = isEditable ? true : false
        setupNavBar()
        print("editable is : \(isEditable)")
    }
 
    func setupNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(EditViewController.doneButton))
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(EditViewController.toggleEditable))
        
        if isEditable {
            navigationItem.setRightBarButtonItem(doneButton, animated: true)
            navigationItem.title = "Edit Goal"
        } else {
            navigationItem.setRightBarButtonItem(editButton, animated: true)
        }
    }
    

    //TODO: - keyboard pushes up textview

}
