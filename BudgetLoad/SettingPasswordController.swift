//
//  SettingPasswordController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class SettingPasswordController: UIViewController {

    //@IBOutlet weak var segmentedControle: UISegmentedControl!
    @IBOutlet weak var lblPassStatus: UILabel!
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var btnSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblPassStatus.userInteractionEnabled = true
        lblPassStatus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SettingPasswordController.setUpPassword)))
        
        self.title = "Password Setting"
        
       
        
       btnSwitch.addTarget(self, action:#selector(SettingPasswordController.stateChangedSwich(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       let pw = userDefaults.stringForKey(IdentifierName.password)
        if pw != nil{
            btnSwitch.on = true
        }else{
            btnSwitch.on = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func stateChangedSwich(switchState: UISwitch) {
        
        if switchState.on{
            setUpPassword()
        }
    }

    
    @IBAction func btnChangePassword(sender: AnyObject) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("ChangePasswordController")
        navigationController?.pushViewController(viewController!, animated: true)
    }
  
    func setUpPassword(){
      
        btnSwitch.on = true
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
       
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("PasswordSetupController")
        navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
}
