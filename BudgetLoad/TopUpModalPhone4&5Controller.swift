//
//  TopUpModalPhone4&5Controller.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 10/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TopUpModalPhone4_5Controller: UIViewController {
    
    @IBOutlet weak var ivNetwork: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTxnNo: UILabel!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblPreBal: UILabel!
    @IBOutlet weak var lblPostBal: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var btnClose: UIButton!
    
    var network:String!
    var status:String!
    var mobileNo:String!
    var datetime:String!
    var amount:String!
    var txnNo:String!
    var product:String!
    var preBal:String!
    var postBal:String!
    var discount:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
        
        self.ivNetwork.image    = UIImage(named: network!)
        self.lblStatus.text     = status!
        self.lblMobileNo.text   = mobileNo!
        self.lblAmount.text     = amount!
        self.lblDateTime.text   = datetime!
        self.lblTxnNo.text      = txnNo!
        self.lblProduct.text    = product!
        self.lblPreBal.text     = preBal!
        self.lblPostBal.text    = postBal!
        self.lblDiscount.text   = discount!
        
        
        btnClose.layer.borderColor = UIColor.grayColor().CGColor
        btnClose.layer.cornerRadius = 5
        btnClose.layer.borderWidth  = 1
        
    }
    
    @IBAction func btnCloseModal(sender: AnyObject) {
        //self.navigationController?.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
