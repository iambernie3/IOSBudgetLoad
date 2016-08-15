//
//  TransactionsController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

//*******
// unused controller
//*******

import UIKit

class TransactionsController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func openDrawer(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    
}
