//
//  VerificationController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 4/4/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class VerificationController: UIViewController {

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var txtCode: UITextField!
    
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmit.layer.cornerRadius = 5
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
        
        
        lblMsg.text = "Your verification code will arrive within \n60 seconds."
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSubmit(sender: AnyObject) {
        
        let text:String = txtCode.text!
        NSUserDefaults.standardUserDefaults().setObject(text, forKey: IdentifierName.verificationCode)
        
        
        if !text.isEmpty{
            self.myActivityIndicator.startAnimating()
           
            if Reachability.isConnectedToNetwork(){
                HttpRequest.verifyCode(text, completion: {
                    (response: String?) in
                    
                    
                    
                    if response! == "OK"{
                        self.myActivityIndicator.stopAnimating()
                                    let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ProfilingController") as! ProfilingController
                                    self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        
                    self.myActivityIndicator.stopAnimating()
                        let alert = UIAlertController(title: "BudgetLoad", message: "Please double check ", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default , handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                   
                })
            }
            

        }
    }
   
}
