//
//  TransactionTopUpController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransactionTopUpController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    let userDefaults =  NSUserDefaults.standardUserDefaults()
    let sharedInstatnce = DatabaseManager()
    var txnInfo : NSMutableArray = NSMutableArray()
    let tutmodel: TopUpTransactionModel = TopUpTransactionModel()
    var json: AnyObject!
    var topModalProtocol: TopUpModalProtocol!
   
    @IBOutlet weak var tblTopTxn: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flagTxn = userDefaults.boolForKey(IdentifierName.hasTopUpTxn)
        
        
        getTxnTopUp()
        
        
        if !flagTxn{
            setDefaultView()
            tblTopTxn!.hidden = true
        }else{
            
        }
        tblTopTxn!.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTxnTopUp(){
        
        
        
        txnInfo = sharedInstatnce.getAllTopUpTxn()
        tblTopTxn!.reloadData()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     
        return txnInfo.count
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TransactionTopUpCell") as! TransactionTopUpCell
        
        if indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        
        let txn: TopUpTransactionModel = txnInfo.objectAtIndex(indexPath.row) as! TopUpTransactionModel
       
        let status = txn.Status
        
        if status == "FAILED"{
            cell.lblStatus.textColor = UIColor.redColor()
        }
        
        
        cell.lblTargetMobTel.text   = txn.TargetMobTel
        cell.lblAmount.text         = "P"+txn.Amount!
        cell.lblStatus.text         = status
        cell.lblDateTime.text       = txn.DateTime
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //let tutmodel: TopUpTransactionModel = TopUpTransactionModel()
        let selectedIndex:TopUpTransactionModel = txnInfo.objectAtIndex(indexPath.row) as! TopUpTransactionModel
        let network = selectedIndex.Network
        let net = getNetworkImage(network)
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5{
            let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("TopUpModalPhone4_5Controller") as!TopUpModalPhone4_5Controller
            modalViewController.network     = net
            modalViewController.amount      = selectedIndex.Amount
            modalViewController.datetime    = selectedIndex.DateTime
            modalViewController.txnNo       = selectedIndex.TxnNo
            modalViewController.preBal      = selectedIndex.PrevBalance
            modalViewController.status      = selectedIndex.Status
            modalViewController.postBal     = selectedIndex.PostBalance
            modalViewController.discount    = selectedIndex.Discount
            modalViewController.product     = selectedIndex.TargetMobTel
            modalViewController.mobileNo    = selectedIndex.SourceMobTel
            
            modalViewController.modalPresentationStyle = .OverCurrentContext
            presentViewController(modalViewController, animated: true, completion: nil)
        
        }else{
            let modalViewController = storyboard?.instantiateViewControllerWithIdentifier("TopUpModalTxnController") as!TopUpModalTxnController
            modalViewController.network     = net
            modalViewController.amount      = selectedIndex.Amount
            modalViewController.datetime    = selectedIndex.DateTime
            modalViewController.txnNo       = selectedIndex.TxnNo
            modalViewController.preBal      = selectedIndex.PrevBalance
            modalViewController.status      = selectedIndex.Status
            modalViewController.postBal     = selectedIndex.PostBalance
            modalViewController.discount    = selectedIndex.Discount
            modalViewController.product     = selectedIndex.TargetMobTel
            modalViewController.mobileNo    = selectedIndex.SourceMobTel
            
            modalViewController.modalPresentationStyle = .OverCurrentContext
            presentViewController(modalViewController, animated: true, completion: nil)
        
        }
       
    }
    
    func getNetworkImage(network:String)->String{
        let net: String!
        switch network {
        case "GLOBE":
            net = "globe"
            break
        case "SUN":
            net = "sun"
            break
        default:
            net = "smart"
            break
        }
        
        return net
    }

    func setDefaultView(){
        let label = UILabel(frame: CGRectMake(0, 100, screenSize.width, 70))
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = label.font.fontWithSize(22)
        label.text = "You do not have any \nTop-Up Transactions."
        
        let image = UIImageView(frame: CGRectMake(0, 0, screenSize.width/2, screenSize.width/2))
        image.image = UIImage(named: "topupimg")
        
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
