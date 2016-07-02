//
//  TextFieldAlert.swift
//  GoalTrackerV3
//
//  Created by Reed Carson on 6/29/16.
//  Copyright © 2016 Reed Carson. All rights reserved.
//

import UIKit


struct TextFieldAlert {
    
    
    let alertController = UIAlertController(title: "Wait", message: "Hey! Hey! Listeeen.", preferredStyle: .Alert)
    
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (let action) -> Void in
        print("ok")
    })
    
    func presentAlert(view: UIViewController) {
        alertController.addAction(okAction)
        view.presentViewController(alertController, animated: true, completion: nil)
    }
}