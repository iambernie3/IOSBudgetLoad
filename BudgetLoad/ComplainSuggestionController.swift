//
//  ComplainSuggestionController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 28/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class ComplainSuggestionController: UIViewController,FileTicketProtocol{

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtComplain: UITextView!
    @IBOutlet weak var lblSelectTicket: UILabel!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var topic:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "File Ticket"
        
        myActivityIndicator.center = view.center
        myActivityIndicator.stopAnimating()
        view.addSubview(myActivityIndicator)
        let mycolor = Reachability.UIColorFromRGB(0xCDD7EC)
        btnSubmit.layer.borderColor = mycolor.CGColor
        btnSubmit.layer.cornerRadius = 10
        btnSubmit.layer.borderWidth = 2
        
        lblSelectTicket.userInteractionEnabled = true
        lblSelectTicket.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ComplainSuggestionController.selectTicket)))
        
        
        
        
    }

    
    @IBAction func btnSubmitComplain(sender: AnyObject) {
        let fName = userDefaults.stringForKey(IdentifierName.fName)
        let lName = userDefaults.stringForKey(IdentifierName.lName)
        myActivityIndicator.startAnimating()
        if topic.isEmpty{
            
            let alert = UIAlertController(title: "", message: "Please select topic.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
        
            let msg = txtComplain.text
            if msg != "(Type Message here)" {
                
                // code here to submit complain/suggestions
                if Reachability.isConnectedToNetwork(){
                    HttpRequest.fileTicket(fName!, lName: lName!, completion: {
                        (response:String?) in
                        
                        if response! == "" || response! == "OK" {
                            self.myActivityIndicator.stopAnimating()
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    })
                }
                
                
            }else{
                myActivityIndicator.stopAnimating()
                let alert = UIAlertController(title: "", message: "Please fill up input message.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func selectTicket(){
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let viewController = storyboard?.instantiateViewControllerWithIdentifier("TopicSelectionController") as! TopicSelectionController
        viewController.topicProtocol = self
        navigationController?.pushViewController(viewController, animated: true)
        
    }

    // protocol function called before poping up from TopicSelectionController
    // set the topic were to complain
    
    func setTicket(topic: String){
        lblSelectTicket.text = topic
        self.topic = topic
    }

}
