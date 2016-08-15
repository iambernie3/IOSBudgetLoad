//
//  RegistrationController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 4/4/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import SCLAlertView

class RegistrationController: UIViewController {
    
    @IBOutlet weak var txtReferrerNumber: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
        
        txtReferrerNumber.userInteractionEnabled = true
        txtReferrerNumber.addTarget(self, action: #selector(RegistrationController.tapReffererLabel(_:)), forControlEvents: UIControlEvents.TouchDown)
        
        //let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrationController.tapReffererLabel(_:)))
        
        //txtReferrerNumber.addGestureRecognizer(tap)
        
    }
    func tapReffererLabel(sender: UITapGestureRecognizer){
        self.modalView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        
        // let vc = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationController") as! VerificationController
        // self.navigationController?.pushViewController(vc, animated: true)
        
        
        let textNumber = txtMobileNumber.text
        let textReferrer = txtReferrerNumber.text
        
        if textReferrer!.isEmpty{
            let alert = UIAlertController(title: "BudgetLoad", message: "Please provide a correct referrer", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if textNumber!.isEmpty{
            let alert = UIAlertController(title: "BudgetLoad", message: "Please provide a correct mobile number", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            myActivityIndicator.startAnimating()
            NSUserDefaults.standardUserDefaults().setObject(textNumber, forKey: IdentifierName.sourceMobTel)
            NSUserDefaults.standardUserDefaults().setObject(textReferrer, forKey: IdentifierName.referrer)
            // before pushing to next controller
            // register the number to remote server, and recieve sms for verification code
            
            if Reachability.isConnectedToNetwork(){
                HttpRequest.registerNumber({
                    (code:String?) in
                    self.myActivityIndicator.stopAnimating()
                    switch code! {
                        
                    case "0001" :
                        print("Account already Exist")
                        let alert = UIAlertController(title: "BudgetLoad", message: "Account already Exist", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        break
                    case "1007":
                        let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Referrer", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        print("Invalid Referrer")
                        break
                    case "1006":
                        let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Source Mobile", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        print("Invalid Source Mobile (prefix not define)")
                        break
                    case "1005":
                        print("Invalid Authentication Code")
                        
                        break
                    case "1004":
                        print("Invalid Session Number")
                        break
                    case "1003":
                        let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Source Mobile", preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        print("Invalid Source Mobile")
                        break
                    case "0000":
                        
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "IsUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        print("your verification code arrive in a moment")
                        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("VerificationController") as! VerificationController
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    default:
                        break
                        
                    }
                    
                })
                
            }else{
                let alert = UIAlertController(title: "BudgetLoad", message: "Check network connections", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Thanks", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                myActivityIndicator.stopAnimating()
            }
            
            
            
        }
    }
    
    func modalView(){
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let height = (screenSize.width / 2)
        let viewHieght:CGFloat
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5{
        
            viewHieght = height + 100
        }else{
        
            viewHieght = height + 30
        }
        
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCircularIcon: true,
            showCloseButton: false
        )
        
        
        let alert = SCLAlertView(appearance: appearance)
        let subview = UIView(frame: CGRectMake(0,0,screenSize.width,viewHieght))
        let subview1 = UIView(frame: CGRectMake(0,0,400,100))
        
        let label1 = UILabel(frame: CGRectMake(10,10,200,150))
        label1.layer.backgroundColor = UIColor.blueColor().CGColor
        label1.textColor = UIColor.whiteColor()
        label1.text = "What is Referrer? \n\nA referrer is the one who invites you to join Budgetload.  \nInput mobile number of your referrer below."
        label1.textAlignment = NSTextAlignment.Center
        label1.font.fontWithSize(16)
        label1.numberOfLines = 0
        label1.layer.cornerRadius = 5
        subview1.addSubview(label1)
        subview.addSubview(subview1)
        
        
        
        //func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect
        
        //******************************
        // iphone 4
        let cg_float_y =  label1.frame.maxY + 10 //height - 22
        
        // iphone 4 beyond
        
        //let cg_float_y = height - 15
        
        //        let label = UILabel(frame: CGRectMake(18,cg_float_y,180,50))
        //        label.text = "Referrer Mobile No"
        //        label.textAlignment = NSTextAlignment.Center
        //        subview.addSubview(label)
        
        // Add textfield 2
        // float_y = label.frame.maxY-7
        let textfield2 = UITextField(frame: CGRectMake(10,cg_float_y,200,40))
        textfield2.keyboardType = UIKeyboardType.NumberPad
        textfield2.layer.borderColor = UIColor.blueColor().CGColor
        textfield2.layer.borderWidth = 1.5
        textfield2.layer.cornerRadius = 5
        textfield2.layer.borderColor = UIColor.blueColor().CGColor
        textfield2.placeholder = "Referrer Mobile No"
        textfield2.textAlignment = NSTextAlignment.Center
        subview.addSubview(textfield2)
        
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        alert.addButton("CANCEL", backgroundColor: UIColor.whiteColor(), textColor:  UIColor.blackColor()) {
            
        }
        
        
        alert.addButton("OK", backgroundColor: UIColor.whiteColor(), textColor: UIColor.greenColor()){
            
            self.txtReferrerNumber.text = textfield2.text!
        }
        
        alert.showSuccess(" ", subTitle: "")
        
    }
    
    
    
}
