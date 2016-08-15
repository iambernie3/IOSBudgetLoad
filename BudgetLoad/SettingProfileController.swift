//
//  SettingProfileController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class SettingProfileController: UIViewController{
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var lblCommunity: UILabel!
    @IBOutlet weak var lblReferrer: UILabel!
    @IBOutlet weak var lblGroup: UILabel!
    @IBOutlet weak var lblDealerType: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblInterest: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblFName: UILabel!
//    @IBOutlet weak var lblMName: UILabel!
//    @IBOutlet weak var lblLName: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var ivLogo: UIButton!
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    var mName:String!
    var fName:String!
    var lName:String!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        myActivityIndicator.center = view.center
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
        ScrollView.contentSize.height = screenSize.height + screenSize.width
        ivLogo.layer.borderColor = UIColor.blueColor().CGColor
        ivLogo.layer.cornerRadius = 50
        ivLogo.layer.borderWidth = 4
        ivLogo.layer.masksToBounds = true
        
        
        editBarButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // fetch profile
        
        if Reachability.isConnectedToNetwork(){
            
            
            let referrer = NSUserDefaults.standardUserDefaults().stringForKey(IdentifierName.referrer)
            
            
            HttpRequest.getProfile({
                (response:NSDictionary?) in
                //print("profile: \(response)")
                
                let result = response!.objectForKey("Result") as? String
                
                if result == "OK" {
                    let ref:String
                    if referrer == nil{
                       ref = (response!.objectForKey("Referrer") as? String)!
                    }else{
                        ref = referrer!
                    }
                    
                     self.mName = response!.objectForKey("MiddleName") as? String
                     self.lName = response!.objectForKey("LastName") as? String
                     self.fName = response!.objectForKey("FirstName") as? String
                    
                        let profileName = "\(self.fName) \(self.mName) \(self.lName)"
                        let email = response!.objectForKey("Email") as? String
                    
                        self.userDefaults.setObject("\(profileName)", forKey: IdentifierName.profileName)
                        self.userDefaults.setObject("\(email!)", forKey: IdentifierName.email)
                        self.userDefaults.setObject("\(self.fName)", forKey: IdentifierName.fName)
                        self.userDefaults.setObject("\(self.lName)", forKey: IdentifierName.lName)
                    
                    
                    let index = self.fName!.startIndex.advancedBy(0)
                    let firstLetter = self.fName[index]
                    
                    //print("letter \(firstLetter)")
                    self.ivLogo.setTitle(String(firstLetter), forState: .Normal)
                    
                    self.lblEmail.text  = email
                    self.lblGroup.text  = response!.objectForKey("GroupCode") as? String
                    self.lblGender.text  = response!.objectForKey("Gender") as? String
                    self.lblMobile.text  = NSUserDefaults.standardUserDefaults().stringForKey(IdentifierName.sourceMobTel)
                    self.lblAddress.text  = response!.objectForKey("Address") as? String
                    self.lblBirthday.text  = response!.objectForKey("BirthDate") as? String
                    self.lblInterest.text  = response!.objectForKey("Interest") as? String
                    self.lblReferrer.text  = ref
                    self.lblCommunity.text  = NSUserDefaults.standardUserDefaults().stringForKey(IdentifierName.community)
                    self.lblDealerType.text  = response!.objectForKey("DealerType") as? String
                    self.lblFName.text  = "\(profileName)"

                    self.lblOccupation.text = response!.objectForKey("Occupation") as? String
                    
                    self.myActivityIndicator.stopAnimating()
                    self.editBarButton.enabled   = true
                }else{
                    self.myActivityIndicator.stopAnimating()
                    let alert = UIAlertController(title: "BudgetLoad", message: "Mobile number not found in the server", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                
                }
            })
        }else{
            self.myActivityIndicator.stopAnimating()
            let alert = UIAlertController(title: "BudgetLoad", message: "Please check your internet connection.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "settingprofile" {
            
                let vc = segue.destinationViewController  as! EditProfileController
            
                vc.birthDay     = self.lblBirthday.text!
                vc.address      = self.lblAddress.text!
                vc.community    = self.lblCommunity.text!
                vc.email        = self.lblEmail.text!
                vc.group        = self.lblGroup.text!
                vc.gender       = self.lblGender.text!
                vc.mobilenumber = self.lblMobile.text!
                vc.interest     = self.lblInterest.text!
                vc.referrer     = NSUserDefaults.standardUserDefaults().stringForKey(IdentifierName.referrer)
                vc.community    = self.lblCommunity.text!
                vc.dealertype   = self.lblDealerType.text!
                vc.fname        = self.fName
                vc.mname        = self.mName
                vc.lname        = self.lName
                vc.occupation   = self.lblOccupation.text!
        }
    }
    
    @IBAction func openDrawer(sender: AnyObject) {
        
        let appDelegat: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegat.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
   // @IBAction func editProfile(sender: AnyObject) {
        
   //     let vc = storyboard?.instantiateViewControllerWithIdentifier("EditProfileController") as! EditProfileController
   //     navigationController?.pushViewController(vc, animated: true)
   // }
    
         
}
