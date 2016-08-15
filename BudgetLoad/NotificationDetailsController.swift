//
//  NotificationDetailsController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 12/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class NotificationDetailsController: UIViewController {

    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblLogo: UILabel!
    
    var header:String!
    var content:String!
    var logo:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblLogo.layer.cornerRadius = 27.0
        lblLogo.layer.masksToBounds = true
        lblLogo.text = logo
        lblContent.text = content
        lblHeader.text = header
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
