//
//  AboutController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 29/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class AboutController: UIViewController {

    @IBOutlet weak var btnTermAndConditions: UIButton!
    @IBOutlet weak var lblAppVersion: UILabel!
    
    var attributedString = NSMutableAttributedString(string:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        //let appVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        lblAppVersion.text = "Version \(App.appVersion)"
        
        let color = Reachability.UIColorFromRGB(0x5dc7c1)
        
        let buttonTitleStr = NSMutableAttributedString(string:"Terms and Condition", attributes:[NSUnderlineStyleAttributeName: 1, NSForegroundColorAttributeName: color] )
        attributedString.appendAttributedString(buttonTitleStr)
        btnTermAndConditions.setAttributedTitle(attributedString, forState: .Normal)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func btnTerms(sender: AnyObject) {
        if let url = NSURL(string: "http://bugetload.com/scr/termcondition.asp") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
   
   

}
