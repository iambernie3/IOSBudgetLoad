//
//  EditProfileController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import SCLAlertView

class EditProfileController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtReferrer: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    @IBOutlet weak var txtCommunity: UITextField!
    @IBOutlet weak var txtDealerType: UITextField!
    @IBOutlet weak var txtGroup: UITextField!
    @IBOutlet weak var txtInterest: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    
    var birthDay:String!
    var fname:String!
    var lname:String!
    var mname:String!
    var address:String!
    var occupation:String!
    var gender:String!
    var referrer:String!
    var community:String!
    var dealertype:String!
    var interest:String!
    var email:String!
    var mobilenumber:String!
    var group:String!
    var btnDone = UIBarButtonItem()
    
    var pickerData:NSArray!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let picker: UIPickerView = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.contentMode = .Bottom
        self.txtGender.inputView = picker
        self.pickerData = ["Male","Female"]
        
        
        
        
        
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
        
        
        if DeviceType.IS_IPHONE_4_OR_LESS{
            scrollView.contentSize.height = (screenSize.height * 2) + screenSize.height + 50
        }else{
            scrollView.contentSize.height = (screenSize.height * 2) + screenSize.width
        }
        
        
        
        btnDone = UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(EditProfileController.confirm))
        navigationItem.rightBarButtonItem = btnDone
        
        
        
        txtBirthday.text        = birthDay
        txtFirstName.text       = fname
        txtMiddleName.text      = mname
        txtMobileNumber.text    = mobilenumber
        txtAddress.text         = address
        txtGender.text          = gender
        txtOccupation.text      = occupation
        txtReferrer.text        = referrer
        txtCommunity.text       = community
        txtDealerType.text      = dealertype
        txtGroup.text           = group
        txtInterest.text        = interest
        txtEmail.text           = email
        txtLastName.text        = lname
        
        
        
        
        
    }
    
    func birthPress(){
        print("meme")
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let gender = pickerData[row]
        return "\(gender)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let gender = pickerData[row]
        self.txtGender.text = "\(gender)"
        self.txtGender.resignFirstResponder()
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData as! String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
        return myTitle
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        //txtGender.userInteractionEnabled = true
        //txtGender.addTarget(self, action: #selector(EditProfileController.genderOption), forControlEvents: UIControlEvents.TouchDown)
        
        
        
       
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("hee1")
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    
    
    func confirm(){
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to update profile?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "UPDATE", style: UIAlertActionStyle.Destructive, handler: {action in self.save()}))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func save(){
        myActivityIndicator.startAnimating()
        let fname: String           = txtFirstName.text!
        let lname: String           = txtLastName.text!
        let mname: String           = txtMiddleName.text!
        let mobilenumber: String    = txtMobileNumber.text!
        let address: String         = txtAddress.text!
        let gender: String          = txtGender.text!
        let occupationn: String     = txtOccupation.text!
        let referrer: String        = txtReferrer.text!
        let birthday: String        = txtBirthday.text!
        let community: String       = txtCommunity.text!
        let dealerType: String      = txtDealerType.text!
        let group: String           = txtGroup.text!
        let interest: String        = txtInterest.text!
        let email: String           = txtEmail.text!
        
        let info:NSDictionary = [
            "fname": fname,
            "lname": lname,
            "mname": mname,
            "mobilenumber":mobilenumber,
            "address": address,
            "gender":gender,
            "occupation": occupationn,
            "referrer":referrer,
            "birthday": birthday,
            "community": community,
            "dealerType": dealerType,
            "group": group,
            "interest": interest,
            "email": email
        ]
        let profileName = "\(fname) \(mname) \(lname)"
        self.userDefaults.setObject("\(profileName)", forKey: IdentifierName.profileName)
        self.userDefaults.setObject("\(email)", forKey: IdentifierName.email)
        self.userDefaults.setObject("\(fname)", forKey: IdentifierName.fName)
        self.userDefaults.setObject("\(lname)", forKey: IdentifierName.lName)
        if Reachability.isConnectedToNetwork(){
            HttpRequest.updateProfile(info, completion: {
                (response: String?) in
                if response! == "OK" {
                    self.myActivityIndicator.stopAnimating()
                    self.navigationController?.popViewControllerAnimated(true)
                }
                
            })
        }else{
            
        }
        
        
        print("save")
    }
    
    
    func genderOption(){
        print("meme")
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let height = (screenSize.width / 2)
        let viewHieght:CGFloat
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5{
            
            viewHieght = height + 50
        }else{
            
            viewHieght = height
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
        let subview1 = UIView(frame: CGRectMake(0,0,400,80))
        
        let label1 = UILabel(frame: CGRectMake(10,10,200,50))
        label1.textColor = UIColor.blackColor()
        label1.text = "Gender:"
        label1.textAlignment = NSTextAlignment.Left
        label1.font.fontWithSize(16)
        label1.numberOfLines = 0
        label1.layer.cornerRadius = 5
        subview1.addSubview(label1)
        subview.addSubview(subview1)
        
        
        
        //func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect
        
        //******************************
        // iphone 4
        //let cg_float_y =  label1.frame.maxY + 10 //height - 22
        
        
        let segmentedButton = UISegmentedControl(frame: CGRectMake(10,50,200,50))
        segmentedButton.insertSegmentWithTitle("Male", atIndex: 0, animated: true)
        segmentedButton.insertSegmentWithTitle("Female", atIndex: 1, animated: true)
        subview.addSubview(segmentedButton)
        // Add the subview to the alert's UI property
        alert.customSubview = subview
        
        alert.addButton("OK", backgroundColor: UIColor.blueColor(), textColor: UIColor.greenColor()){
            
            let index = segmentedButton.selectedSegmentIndex
            
            switch index {
            case 0 :
                self.txtGender.text = "Male"
                break
            case 1:
                self.txtGender.text = "Female"
                break
            default:
                break
            }
            
            
        }
        
        alert.showSuccess(" ", subTitle: "")
    }
    
    
    @IBAction func birthDay(sender: UITextField) {
        
//                let vc =  storyboard?.instantiateViewControllerWithIdentifier("DatePickerController") as? DatePickerController
//                vc?.modalPresentationStyle = .OverCurrentContext
//                presentViewController(vc!, animated: true, completion: nil)
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        
        
        datePickerView.addTarget(self, action: #selector(EditProfileController.datePickerValueChanged),forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        txtBirthday.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    
}
