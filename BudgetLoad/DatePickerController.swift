//
//  DatePickerController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 11/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnSet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        datePicker.datePickerMode = UIDatePickerMode.Date
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSet(sender: AnyObject) {
        //var date = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        
        print("\(strDate)")
        
    }
    
   
    @IBAction func btnback(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
