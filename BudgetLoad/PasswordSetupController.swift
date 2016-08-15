//
//  PasswordSetupController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class PasswordSetupController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var submit = UIBarButtonItem()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Password Setup"
        
        submit = UIBarButtonItem(title: "SUBMIT", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(PasswordSetupController.submitPassword))
        navigationItem.rightBarButtonItem = submit
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func submitPassword() {
        let pw:String = txtPassword.text!
        let confirmPW:String = txtConfirmPassword.text!
        
        if pw.isEmpty || confirmPW.isEmpty{
            let alert = UIAlertController(title: "BudgetLoad", message: "Please complete the field..", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else if  pw != confirmPW {
            let alert = UIAlertController(title: "BudgetLoad", message: "Password did not match", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if Reachability.isConnectedToNetwork(){
                
                HttpRequest.changePassword(pw, completion: {
                    (response:String?) in
                    
                    if response! == "OK"{
                        self.userDefaults.setObject(pw, forKey: IdentifierName.password)
                        self.txtConfirmPassword.text = ""
                        self.txtPassword.text   = ""
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
