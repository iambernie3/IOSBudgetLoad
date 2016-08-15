//
//  SettingsController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var lblCredit: UILabel!
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openDrawer(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
//    @IBAction func btnProfile(sender: AnyObject) {
//        let vc = storyboard?.instantiateViewControllerWithIdentifier("SettingProfileController")
//            navigationController?.pushViewController(vc!, animated: true)
//    }
    
    @IBAction func btnPassword(sender: AnyObject) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let vc = storyboard?.instantiateViewControllerWithIdentifier("SettingPasswordController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnFAQ(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("FAQController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnComplain(sender: AnyObject) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ComplainSuggestionController")
        navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnDeactivate(sender: AnyObject) {
        let msg = "Choosing 'Deactivate' will clear all of your data and remove your account from all other devices. Please note that you can't deactivate your account if you still have available credits."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        let messageText = NSMutableAttributedString(
            string: msg,
            attributes: [
                NSParagraphStyleAttributeName: paragraphStyle
               
            ]
        )
        
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.setValue(messageText, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default , handler: {action in self.deActivate()}))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func btnAbout(sender: AnyObject) {
        
        let vc = storyboard?.instantiateViewControllerWithIdentifier("AboutController")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func deActivate(){
        //code here to deactivate account
        let credits = lblCredit.text
        
        if credits == "0.00" {
            if Reachability.isConnectedToNetwork(){
                HttpRequest.deactivateAccount({
                    (response:String?) in
                    
                    if (response! == "Successful"){
                        let alert = UIAlertController(title: "BudgetLoad", message: "Account Deactivated", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertActionStyle.Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                })
            }
        }else{
            let alert = UIAlertController(title: "BudgetLoad", message: "You still have credits", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "CLOSE", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBAction func btnFetchWallet(sender: AnyObject) {
        myActivityIndicator.startAnimating()
        if Reachability.isConnectedToNetwork(){
            HttpRequest.walletBalance({
                (response:NSDictionary?) in
                
                let ResultCode  = response!.objectForKey("ResultCode") as? String
                let Credits     = response!.objectForKey("Credits") as? String
                self.myActivityIndicator.stopAnimating()
                switch ResultCode!{
                case "0000" :
                    self.lblCredit.text = Credits
                    
                    break
                case "1012" :
                    let alert = UIAlertController(title: "BudgetLoad", message: "Not enough wallet", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                case "1006":
                    let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Target Mobile", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                case "1007":
                    let alert = UIAlertController(title: "BudgetLoad", message: "Mobile Number not found.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                default:
                    break
                }
                
            })
        }else{
            myActivityIndicator.stopAnimating()
            let alert = UIAlertController(title: "BudgetLoad", message: "No network connections", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
}
