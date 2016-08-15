//
//  ChangePasswordController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController {

    var submit = UIBarButtonItem()
    
    @IBOutlet weak var txtNewPW: UITextField!
    @IBOutlet weak var txtCurrentPW: UITextField!
    @IBOutlet weak var txtConfirmPW: UITextField!
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Change Password"
        
        submit = UIBarButtonItem(title: "SUBMIT", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.sumbitNewPassword))
        navigationItem.rightBarButtonItem = submit
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sumbitNewPassword(){
        let currentpw:String = txtCurrentPW.text!
        let confirmPW:String = txtConfirmPW.text!
        let newPW:String     = txtNewPW.text!
        if currentpw.isEmpty || confirmPW.isEmpty || newPW.isEmpty{
            let alert = UIAlertController(title: "BudgetLoad", message: "Please complete the field..", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if  newPW != confirmPW {
            let alert = UIAlertController(title: "BudgetLoad", message: "Password did not match..", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if Reachability.isConnectedToNetwork(){
                
                HttpRequest.changePassword(newPW, completion: {
                    (response:String?) in
                    
                    if response! == "OK"{
                        self.userDefaults.setObject(newPW, forKey: IdentifierName.password)
                        self.txtNewPW.text = ""
                        self.txtConfirmPW.text   = ""
                        self.txtCurrentPW.text   = ""
                    }else{
                        let alert = UIAlertController(title: "BudgetLoad", message: "Sorry! Password cannot save, something wrong with the server.", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                    
                })
                
            }
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
