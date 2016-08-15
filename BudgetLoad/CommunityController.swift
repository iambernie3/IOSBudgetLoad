//
//  CommunityController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 3/29/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class CommunityController: UIViewController,myProtocol,UITextFieldDelegate {
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txtCommunity: UITextField!
    
    var passedValue: String!
    var UniqueID: String!
    
    @IBOutlet weak var txtCommID: UITextField!
    @IBOutlet weak var lblCommName: UILabel!
    
    var contacts: [String] = []
    var communityList: NSArray = []
    var alert = UIAlertController()
    
    let para:NSMutableDictionary = NSMutableDictionary()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmit.layer.cornerRadius = 5
        //btnSubmit.layer.borderWidth = 1
        //btnSubmit.layer.borderColor = UIColor.whiteColor().CGColor
        
        //        alert = UIAlertController(title: "BudgetLoad", message: "Fetching community. Please wait...", preferredStyle: .Alert)
        //        alert.view.tintColor = UIColor.blackColor()
        //        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        //        loadingIndicator.hidesWhenStopped = true
        //        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        //        loadingIndicator.startAnimating();
        
        
        //alert.view.addSubview(loadingIndicator)
        //presentViewController(alert, animated: true, completion: nil)
        
        txtCommID.addTarget(self, action: #selector(CommunityController.myTargetFunction(_:)), forControlEvents: UIControlEvents.TouchDown)
        
        UniqueID = GUIDString() as String
        
        // updateIP()
        
        //performSegueWithIdentifier("go", sender: self)
        
        
    }
    
    func updateIP() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        //let postEndpoint: String = "http://dev2-misc.budgetload.com:8282/"
        var urlWithParams = UrlVariable.OTHERSURL + "?id=d6b27ee9de22e000700f0163e662ecba1d201c99"
        urlWithParams = urlWithParams + "&cmd=COMMUNITY"
        urlWithParams = urlWithParams + "&IMEI=\(UniqueID)"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlWithParams)!
        
        print(url)
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            
            
            //self.dismissViewControllerAnimated(false, completion: nil)
            
            
            // Read the JSON
            do {
                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    // Print what we got from the call
                    //print(ipString)
                    
                    // Parse the JSON to get the IP
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
                    print(jsonDictionary)
                    self.communityList = (jsonDictionary.valueForKey("Community") as? NSArray)!
                    // print(jsonDictionary)
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    //print(self.communityList)
                    //                if let communityList = jsonDictionary.valueForKey("Community") as? NSArray {
                    //                    for js in communityList {
                    //                        let networkid = js.valueForKey("NetworkID")
                    //                        let networkname = js.valueForKey("NetworkName")
                    //                    }
                    //                }
                    
                    // Update the label
                    //self.performSelectorOnMainThread("updateIPLabel:", withObject: nil, waitUntilDone: false)
                    
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func myTargetFunction(textField: UITextField) {
        // user touch field
        
        //self.navigationController!.pushViewController(self.storyboard!.instantiateViewControllerWithIdentifier("go") as UIViewController, animated: true)
        //print(self.communityList)
        performSegueWithIdentifier("go", sender: self)
        
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        
        if segue.identifier == "go" {
            //            let tableVC = segue.destinationViewController as! CommListController
            //            // Pass the object
            //            tableVC.selectedLabel = passedValue
            let tableTV : CommListController = segue.destinationViewController as! CommListController
            tableTV.myprotocol = self
            
        }
        
    }
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        let comm:String = txtCommID.text!
        let com_id:String = lblCommName.text!
        
        if !comm.isEmpty {
            
            NSUserDefaults.standardUserDefaults().setObject(com_id, forKey: IdentifierName.partnerID)
            NSUserDefaults.standardUserDefaults().setObject(comm, forKey: IdentifierName.community)
            
            let vc = storyboard?.instantiateViewControllerWithIdentifier("RegistrationController") as!  RegistrationController
            
            navigationController?.pushViewController(vc, animated: true)
            
        }else {
        
            let alert = UIAlertController(title: "BudgetLoad", message: "Please select a community", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        print("(comm: \(comm)) id: \(com_id)")
        
    }
    
    func didSelectRow(communityID: String,communityName: String)
    {
        //print("Here @community")
        txtCommID.text = communityName
        lblCommName.text = communityID
    }
    
    func updateIPLabel(text: String) {
        //self.dismissViewControllerAnimated(false, completion: nil)
        // self.txtCommunity.text = "Your IP is " + text
    }
    
    
    
}
