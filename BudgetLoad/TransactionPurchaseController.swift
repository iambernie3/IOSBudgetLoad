//
//  TransactionPurchaseController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransactionPurchaseController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let userDefaults =  NSUserDefaults.standardUserDefaults()
    let sharedInstance = DatabaseManager()
    var purchaseModel:PurchaseTxnModel = PurchaseTxnModel()
    var purchaseArray: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var tblPurchase: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let hasTnx:Bool = userDefaults.boolForKey(IdentifierName.hasPurchaseTxn)
        getAllPurchaseTxn()
        
        if !hasTnx {
            setDefaultView()
            tblPurchase.hidden = true
        }
        
        tblPurchase.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllPurchaseTxn(){
        //*************************************
        // Note : 
        //      Purchase Txn fetch done from the TransactionsTabBarController -> HttRequest -> DatabaseModel
        //*************************************
        
        purchaseArray = sharedInstance.getAllPurchaseTxn()
        tblPurchase.reloadData()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return purchaseArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("PurchaseTransactionCell") as! PurchaseTransactionCell
        
        if indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        let model:PurchaseTxnModel = purchaseArray.objectAtIndex(indexPath.row) as! PurchaseTxnModel
        
        cell.lblAmount.text         = "P"+model.Amount+".00"
        cell.lblStatus.text         = model.TxnStatus
        cell.lblDateTime.text       = model.DateTime
        cell.lblTxnNo.text          = model.ReferenceNo
        cell.lblBranch.text         = model.TerminalID
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func setDefaultView(){
        
        
        let label = UILabel(frame: CGRectMake(0, 100, screenSize.width, 70))
        let image = UIImageView(frame: CGRectMake(0,0, screenSize.width/2, screenSize.width/2))
        
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Center
        label.font = label.font.fontWithSize(22)
        label.text = "You do not have any \nPurchase Transactions."
        
        
        image.image = UIImage(named: "purchaseimg")
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
        
        let imageH = NSLayoutConstraint(item: image, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: screenSize.width/2)
        
        let imageW = NSLayoutConstraint(item: image, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: screenSize.width/2)
        
        
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal,
                                        toItem: view, attribute: .Top, multiplier: 1.0, constant: 100)
        let imagepinTop = NSLayoutConstraint(item: image, attribute: .Top, relatedBy: .Equal,
                                             toItem: view, attribute: .Top, multiplier: 1.0, constant: 200)
        
        
        let xImageConstraint = NSLayoutConstraint(item: image, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        
        //when using autolayout we an a view, MUST ALWAS SET translatesAutoresizingMaskIntoConstraints
        //to false.
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
