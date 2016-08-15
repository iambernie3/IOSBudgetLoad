//
//  StockTransferController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/21/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class StockTransferController: UIViewController,StockTransferProtocol,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var lblCredit: UILabel!
    @IBOutlet weak var ivWallet: UIImageView!
    @IBOutlet weak var imgContacts: UIImageView!
    @IBOutlet weak var txtRecipient: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var number:String! = ""
    var partner_id:String!
    
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
        
        NSUserDefaults.standardUserDefaults().setObject("stocktransfer", forKey: "controller")
        
         let mycolor = Reachability.UIColorFromRGB(0xCDD7EC)
        
        txtRecipient.delegate = self
        
        txtRecipient.layer.borderColor = mycolor.CGColor
        txtRecipient.layer.borderWidth = 1
        
        txtAmount.layer.borderColor = mycolor.CGColor
        txtAmount.layer.borderWidth = 1
        
        imgContacts.layer.borderColor = mycolor.CGColor
        imgContacts.layer.borderWidth = 1
        
        btnSubmit.layer.borderColor = mycolor.CGColor
        btnSubmit.layer.cornerRadius = 10
        btnSubmit.layer.borderWidth = 2
        
        
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(StockTransferController.goToContact(_:)) )
        imgContacts.addGestureRecognizer(imageTap)
        
        let imageWallet = UITapGestureRecognizer(target: self, action: #selector(StockTransferController.fetchWallet(_:)) )
        ivWallet.addGestureRecognizer(imageWallet)

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @IBAction func openDrawer(sender: AnyObject) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
        
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        number=number+string
        
        let charCount = number.characters.count
        
        if  charCount == 11 {
            if Reachability.isConnectedToNetwork(){
                
                HttpRequest.getTargetPartnerID(number, completion:{
                    (response:String?) in
                    
                    self.partner_id = response!
                    print("partner id : \(response)")
                })
                
            }else{
                let alert = UIAlertController(title: "BudgetLoad", message: "Can't get 'TARGET PARTNER ID', please check your connection. ", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "THANKS", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        return true
    }
    func targetNumber() -> String{
        let number = txtRecipient.text
        return number!
    }
    
    func goToContact(sender: UITapGestureRecognizer){
         let viewController = storyboard?.instantiateViewControllerWithIdentifier("ContactsController") as! ContactsController
         viewController.stockTransfer = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        print("submit")
        self.txtRecipient.resignFirstResponder()
        
        let string = self.txtRecipient.text
        
        let count = string?.characters.count
        
        if count == 11 {
            let firsFourLetters = string!.startIndex.advancedBy(0) ..< string!.startIndex.advancedBy(4)
            let str = string!.substringWithRange(firsFourLetters)
            let brand = SimIdentification().parseJson(str)
            
            if brand.isEmpty {
                
                let alert = UIAlertController(title: "Note", message: "Invalid mobile number", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }else{
                //print("success")
                stockTranserAPI()
            }
        }else{
            let alert = UIAlertController(title: "Note", message: "Invalid mobile number", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    
    func setRecipient(phone:String){
        
        txtRecipient.text = phone
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
                    self.lblCredit.text = Credits
                    self.ivWallet.image = UIImage(named: "walletsmalloff")
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
    
    func stockTranserAPI(){
        
        let amount = txtAmount.text
        let targetMobTel = txtRecipient.text
        
        if !amount!.isEmpty{
            
            if Reachability.isConnectedToNetwork(){
                if !self.partner_id.isEmpty{
                    HttpRequest.stockTransfer(amount!, targetMobTel: targetMobTel!,partnerID: partner_id,completion: {
                        (response:String?) in
                        
                        switch response!{
                        case "1012":
                            let alert = UIAlertController(title: "BudgetLoad", message: "Not enough wallet", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "THANKS", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            break
                        case "1006":
                            let alert = UIAlertController(title: "BudgetLoad", message: "Invalid Target Mobile", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "THANKS", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            break
                        case "0000":
                            let alert = UIAlertController(title: "BudgetLoad", message: "Successful", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "THANKS", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                            // Note: Alamofire is an asynchronous type,
                            // fetch ahead for creadit transfer transaction
                            // by code below
                                if Reachability.isConnectedToNetwork(){
                                    HttpRequest.getStockTransferTransaction({
                                        (response:String?) in
                                        
                                    })
                                }
                            
                            
                            self.txtAmount.text = ""
                            self.txtRecipient.text = ""
                            break
                        default:
                            break
                        }
                    })
                }else{
                    let alert = UIAlertController(title: "BudgetLoad", message: "You don't have partner id.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                
            }
        
        }else{
            let alert = UIAlertController(title: "BudgetLoad", message: "No network connections", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        
    
    }
   
}







