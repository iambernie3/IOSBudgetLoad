//
//  TransferModalController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 09/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransferModalController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblSenderCom: UILabel!
    @IBOutlet weak var lblReciever: UILabel!
    @IBOutlet weak var lblRecieverCom: UILabel!
    @IBOutlet weak var lblTxnNo: UILabel!
    @IBOutlet weak var lblReciverPrevStock: UILabel!
    @IBOutlet weak var lblRecieverPrevAvailable: UILabel!
    @IBOutlet weak var lblPostBalance: UILabel!    
    @IBOutlet weak var lblPreBalance: UILabel!
    @IBOutlet weak var lblRecieverPrevConsumed: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    // label
    @IBOutlet weak var labelSenderCom: UILabel!
    @IBOutlet weak var labelRecieverPrevStock: UILabel!
    @IBOutlet weak var labelRecieverCom: UILabel!
    @IBOutlet weak var labelRPrevConsumed: UILabel!
    @IBOutlet weak var labelRPrevAvai: UILabel!
    
    
    var status:String!
    var sender:String!
    var reciever:String!
    var txnNo:String!
    var recieverPrevAvailable:String!
    var postBalance:String!
    var preBalance:String!
    var recieverPrevConsumed:String!
    var amount:String!
    var dateTime:String!
    var senderCom:String!
    var recieverPrevStock:String!
    var recieverCom:String!
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5 {
            scrollView.contentSize.height = screenSize.height + screenSize.width
            scrollView.contentSize.width = screenSize.width + 60
        }
        else{
            scrollView.contentSize.height = screenSize.height
            //scrollView.contentSize.width = screenSize.width
        }
        
        
        self.labelSenderCom.text = "Sender\nCommunity:"
        self.labelRecieverPrevStock.text = "Reciever\nPrev Stock:"
        self.labelRecieverCom.text  = "Reciever\nCommunity:"
        self.labelRPrevConsumed.text = "Reciever\nPrev\nConsumed:"
        self.labelRPrevAvai.text     = "Reciever\nPrev\nAvailable:"
        
        lblStatus.text      = "SUCCESS"
        lblSender.text      = sender
        lblSenderCom.text   = senderCom
        lblDateTime.text    = dateTime
        lblTxnNo.text       = txnNo
        lblReciever.text    = reciever
        lblRecieverCom.text      = recieverCom
        lblReciverPrevStock.text    = "P"+recieverPrevStock
        lblRecieverPrevConsumed.text     =  "P"+recieverPrevConsumed
        lblRecieverPrevAvailable.text    = "P"+recieverPrevAvailable
        lblAmount.text      = "P"+amount+".00"
        lblPreBalance.text  = preBalance
        lblPostBalance.text = postBalance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnDismissModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

   

}
