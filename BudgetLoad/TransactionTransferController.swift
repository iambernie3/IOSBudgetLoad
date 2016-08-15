//
//  TransactionTransferController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransactionTransferController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblTransferTxn: UITableView!
    
    
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let sharedinstance = DatabaseManager()
    var transferArray: NSMutableArray = NSMutableArray()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let txnModel: TransferTxnModel = TransferTxnModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hasTTxn = userDefaults.boolForKey(IdentifierName.hasTransferTxn)
        if !hasTTxn{
            tblTransferTxn.hidden = true
            setDefaultView()
        }
        
        getTranferTxn()
        tblTransferTxn.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDefaultView(){
        let label = UILabel(frame: CGRectMake(0, 100, screenSize.width, 70))
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = label.font.fontWithSize(22)
        label.text = "You do not have any \nStock Transfer Transactions."
        
        let image = UIImageView(frame: CGRectMake(0, 0, screenSize.width/2, screenSize.width/2))
        image.image = UIImage(named: "transferimg")
        
        
        self.view.addSubview(label)
        self.view.addSubview(image)
        
        //pin the label 20 points from the right edge of the super view
        let labelContraints = NSLayoutConstraint(item: label, attribute:
            .LeadingMargin, relatedBy: .Equal, toItem: view,
                            attribute: .LeadingMargin, multiplier: 1.0,
                            constant: 20)
        
        //negative because we want to pin -20 points from the end of the superview.
        //ex. if with of super view is 300, 300-20 = 280 position
        let label2Contraints = NSLayoutConstraint(item: label, attribute:
            .TrailingMargin, relatedBy: .Equal, toItem: view,
                             attribute: .TrailingMargin, multiplier: 1.0, constant: -20)
        
        let imageH = NSLayoutConstraint(item: image, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: screenSize.height/2)
        
        let imageW = NSLayoutConstraint(item: image, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: screenSize.width/2)
        
        let pinTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal,
                                        toItem: view, attribute: .Top, multiplier: 1.0, constant: 100)
        let imagepinTop = NSLayoutConstraint(item: image, attribute: .Top, relatedBy: .Equal,
                                             toItem: view, attribute: .Top, multiplier: 1.0, constant: 200)
        
        
        let xImageConstraint = NSLayoutConstraint(item: image, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([labelContraints, label2Contraints,pinTop,xImageConstraint,imagepinTop,imageH,imageW])
    }

    func getTranferTxn(){
        
        //*************************************
        // Note :
        //      Stock Transfer Txn fetch done from the StockTransferController(submission of stock transfer) ->
        //      HttRequest -> DatabaseModel
        //*************************************
        
        transferArray = sharedinstance.getAllTransferTxn()
        tblTransferTxn.reloadData()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return transferArray.count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TransferTxnCell") as! TransferTxnCell
        
        if indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        
        let txn: TransferTxnModel = transferArray.objectAtIndex(indexPath.row) as! TransferTxnModel
       
        cell.lblInfo.text = txn.Retailer
        cell.lblReciever.text = txn.SubDistributor
        cell.lblAmount.text   = "P "+txn.Amount+".00"
        cell.lblDate.text     = txn.DateTime
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedIndex = transferArray.objectAtIndex(indexPath.row) as! TransferTxnModel
        
        let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("TransferModalController") as!TransferModalController
              modalViewController.modalPresentationStyle = .OverCurrentContext
        
             modalViewController.amount     = selectedIndex.Amount
             modalViewController.dateTime   = selectedIndex.DateTime
            modalViewController.postBalance = selectedIndex.PostBalance
            modalViewController.preBalance  = selectedIndex.PreBalance
            modalViewController.reciever    = selectedIndex.SubDistributor
            modalViewController.recieverCom = selectedIndex.ReceiverCommunity
            modalViewController.recieverPrevAvailable   = selectedIndex.RetailerPrevAvailable
            modalViewController.recieverPrevConsumed    = selectedIndex.RetailerPrevConsumed
            modalViewController.recieverPrevStock       = selectedIndex.RetailerPrevStock
            modalViewController.sender                  = selectedIndex.Retailer
            modalViewController.senderCom               = selectedIndex.SenderCommunity
            modalViewController.txnNo                   = selectedIndex.TxnID
        
        
        presentViewController(modalViewController, animated: true, completion: nil)
        
    }
    
    func getTextWithColor(str:String)-> NSMutableAttributedString{
        let range = (str as NSString).rangeOfString(str)
        let senderAttrString = NSMutableAttributedString(string: str)
        senderAttrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: range)
        return senderAttrString
    }


}
