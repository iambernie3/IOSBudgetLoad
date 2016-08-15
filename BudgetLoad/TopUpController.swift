//
//  TopUpController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit
import CoreLocation

class TopUpController: UIViewController,UITextFieldDelegate,TopUpProtocol,ProductTypeProtocol , CLLocationManagerDelegate{
    
    
    @IBOutlet weak var lblCredits: UILabel!
    @IBOutlet weak var ivTopUp: UIImageView!
    @IBOutlet weak var txtNetwork: UITextField!
    @IBOutlet weak var txtRecipient: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtProductType: UITextField!
    @IBOutlet weak var imgContact: UIImageView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    let currencyFormatter = NSNumberFormatter()
    var currentLocation = CLLocation()
    let locManager = CLLocationManager()
    var latitude:String!
    var longitude:String!
    var loadAmount:String!
    var loading:Bool = true
    var productCode:String!
    
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
        
        txtNetwork.delegate = self
        txtRecipient.delegate = self
        
        let mycolor = Reachability.UIColorFromRGB(0xCDD7EC)
        txtRecipient.layer.borderColor = mycolor.CGColor
        txtRecipient.layer.borderWidth = 1
        
        txtNetwork.layer.borderColor = mycolor.CGColor
        txtNetwork.layer.borderWidth = 1
        
        txtProductType.layer.borderColor = mycolor.CGColor
        txtProductType.layer.borderWidth = 1
        
        txtAmount.layer.borderColor = mycolor.CGColor
        txtAmount.layer.borderWidth = 1
        
        imgContact.layer.borderColor = mycolor.CGColor
        imgContact.layer.borderWidth = 1
        
        
        btnSubmit.layer.borderColor = mycolor.CGColor
        btnSubmit.layer.cornerRadius = 10
        btnSubmit.layer.borderWidth = 2
        
        //txtAmount.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        //txtAmount.frame = CGRect(x: 0, y: 40, width: 320, height: 40)
        //txtAmount.keyboardType = UIKeyboardType.NumberPad
        //txtAmount.backgroundColor = UIColor.lightGrayColor()
        //self.view.addSubview(textField)
        
        //currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyAccountingStyle
        //currencyFormatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
        
        
        
        //**************
        // note:
        // make txtProductType:UITextField enable gezture recognizer, overlay the view on top of a textfield
        // this action will go through Product Type Controller
        //**************
        // Gezture Recognizer for selecting product
        let geztureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopUpController.selectProductType(_:)))
        let gezture = UIView(frame: self.txtProductType.frame)
        self.view.addSubview(gezture)
        gezture.addGestureRecognizer(geztureRecognizer)
        
        //Gezture Recognizer for selecting contact
        let imageGeztureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopUpController.selectContact(_:)))
        imgContact.addGestureRecognizer(imageGeztureRecognizer)
        
        let ivTopUpGeztureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TopUpController.fetchWallet(_:)))
        ivTopUp.addGestureRecognizer(ivTopUpGeztureRecognizer)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        locManager.requestWhenInUseAuthorization()
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startMonitoringSignificantLocationChanges()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            
            currentLocation = locManager.location!
            latitude = "\(currentLocation.coordinate.latitude)"
            longitude = "\(currentLocation.coordinate.longitude)"
        }
    }
    
    
    func textFieldDidChange(textField: UITextField) {
        let text = textField.text!
            .stringByReplacingOccurrencesOfString(currencyFormatter.groupingSeparator, withString: "")
            .stringByReplacingOccurrencesOfString(currencyFormatter.decimalSeparator, withString: "")
        textField.text = currencyFormatter.stringFromNumber((text as NSString).doubleValue / 100.0)
        
        
        //.stringByReplacingOccurrencesOfString(currencyFormatter.currencySymbol, withString: "")
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //txtNetwork.text = ""
        //print("hee")
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        //print("hee1")
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        return false
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let count = range.location + 1
        let string = txtRecipient.text
        
        
        
        if  count == 11 {
            let firsFourLetters = string!.startIndex.advancedBy(0) ..< string!.startIndex.advancedBy(4)
            let str = string!.substringWithRange(firsFourLetters)
            
            let brand = SimIdentification().parseJson(str)
            txtNetwork.text = brand
            
            
        }else if count > 11 {
            
            txtNetwork.text = ""
            
        }else if count < 11 {
            txtNetwork.text = ""
        }
        
        
        return true
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func openDrawer(sender: AnyObject) {
        
        let appDelegat: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegat.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectProductType(sender: UITapGestureRecognizer){
        
        let recipient: String = self.txtRecipient.text!
        let network: String   = self.txtNetwork.text!
        
        if recipient.isEmpty{
            let alert = UIAlertController(title: "BudgetLoad", message: "Please provide recipient number", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            
            NSUserDefaults.standardUserDefaults().setObject(network, forKey: IdentifierName.productNetwork)
            
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ProductTypeController") as! ProductTypeController
            vc.productProtocol = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func selectContact(sender: UITapGestureRecognizer){
        
        NSUserDefaults.standardUserDefaults().setObject("topup", forKey: "controller")
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("ContactsController") as! ContactsController
        viewController.topupProtocol = self
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    // protocol method
    func setContact(number: String,brand: String){
        txtRecipient.text = number
        txtNetwork.text = brand
    }
    // protocol method
    func setProduct(product:String, amount:String, productCode:String){
        self.loadAmount = amount
        self.txtAmount.text = amount
        self.txtProductType.text = product
        self.productCode = productCode
        
    }
    
    @IBAction func btnSubmitAction(sender: AnyObject) {
        self.txtRecipient.resignFirstResponder()
        
        let string = self.txtRecipient.text
        
        let count = string?.characters.count
        
        if count == 11 {
            let firsFourLetters = string!.startIndex.advancedBy(0) ..< string!.startIndex.advancedBy(4)
            let str = string!.substringWithRange(firsFourLetters)
            let brand = SimIdentification().parseJson(str)
            
            if brand.isEmpty {
                
                let alert = UIAlertController(title: "BudgetLoad", message: "Invalid mobile number", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                validateField()
            }
        }else{
            let alert = UIAlertController(title: "BudgetLoad", message: "Invalid mobile number", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func validateField(){
        
        let product = self.txtProductType.text!
        let network = self.txtNetwork.text!
        
        if product == ""{
            let alert = UIAlertController(title: "BudgetLoad", message: "Please fill up the field", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            print("success")
            print("coordinate : \(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")
            
            
            
            
            
            
            let topup:NSDictionary = [
                "TargetMobTel"    : txtRecipient.text!,
                "ProductCode"     : productCode,
                "Amount"          : txtAmount.text!,
                "Longitude"       : "\(currentLocation.coordinate.longitude)",
                "Latitude"        : "\(currentLocation.coordinate.latitude)"
            ]
            
            if Reachability.isConnectedToNetwork(){
                
                HttpRequest.topUpLoad(topup, completion: {
                    (response:String?) in
                    
                    switch response! {
                    case "0000" :
                        NSUserDefaults.standardUserDefaults().setObject(network, forKey: IdentifierName.productNetwork)
                        let alert = UIAlertController(title: "BudgetLoad", message: "TopUp Success", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        
                        self.txtAmount.text = ""
                        self.txtRecipient.text = ""
                        self.txtNetwork.text = ""
                        self.txtProductType.text = ""
                        
                        
                        // Note: Alamofire is an asynchronous type,
                        // fetch ahead for transaction list
                        // by code below
                        if Reachability.isConnectedToNetwork(){
                            HttpRequest.getTopUpTransaction({
                                (response:String?) in
                            })
                        }
                        
                        //send notification TOPUP txn
                        //                            let email = self.userDefaults.stringForKey(IdentifierName.email)
                        //                            print("email: \(email)")
                        //                            if email != nil{
                        //                                HttpRequest.sendNotification("TOPUP", email: email!, completion: {
                        //                                    (response:String?) in
                        //                                })
                        //                            }
                        
                        
                        break
                    case "1010":
                        let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Amount", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        break
                    case "1006":
                        let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Target Mobile", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                        break
                    default:
                        break
                    }
                    
                    
                })
            }else{
                
                let alert = UIAlertController(title: "BudgetLoad", message: "No network connections", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func fetchWallet(sender: UITapGestureRecognizer){
        
        myActivityIndicator.startAnimating()
        
        if Reachability.isConnectedToNetwork(){
            HttpRequest.walletBalance({
                (response:NSDictionary?) in
                
                let ResultCode  = response!.objectForKey("ResultCode") as? String
                let Credits     = response!.objectForKey("Credits") as? String
                self.myActivityIndicator.stopAnimating()
                switch ResultCode!{
                case "0000" :
                    self.lblCredits.text = Credits
                    self.ivTopUp.image = UIImage(named: "walletsmalloff")
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
            let alert = UIAlertController(title: "BudgetLoad", message: "No network connections", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    //    func waitForFetching(){
    //
    //        if loading {
    //            let alert = UIAlertController(title: "BudgetLoad", message: "Please wait...", preferredStyle: .Alert)
    //
    //            self.presentViewController(alert, animated: true, completion: nil)
    //        }
    //    }
}




