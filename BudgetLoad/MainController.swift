//
//  MainController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/19/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class MainController:UIViewController{
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func OpenDrawer(sender: AnyObject) {
        let appDeletegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDeletegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
   
    
    
}
