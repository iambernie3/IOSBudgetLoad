//
//  FAQController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 29/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class FAQController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    
    let about = ["What is BudgetLoad?","How to use budgetload?","What is the use of email address during registration?",
                    "Where to purchase load Credit for the Wallet?","How to topup?","What are the Mobile Networks available in BudgetLoad?","How to recover account when lost phone?","How to transfer wallet to other number?","How to deactivate account?","How to keep track of the Purchase of Load Credits?","How to know if the Top-Up transaction is successful or not?","How to view older transactions?","       "]
    
    let details = ["BudgetLoad is a quick, simple and secure airtime reloading for mobile network like Globe,Smart, and Sun.","User can download the BudgetLoad App in Google App Store, and Play Store. After downloading, open the BudgetLoad Application. The first time that the User uses this App, it will ask for a registration of the mobile number. By registering the mobile number, a verification code will be sent via text. User must type the correct verification code in order to start using the BudgetLoad. User must take note that an Internet Connection is a must in order to use the BudgetLoad Application.","By verifying the email address, the user can retrieve its account when phone is lost. The user can also view older transactions from its credit purchases and Top-Ups.","User can purchase load credit from any Remitbox Outlet(HLHUILLIER, PRIMEASIA, GEMMARY), Gaisano Capital, GMart Stores..","To Top-Up, User must input the correct mobile number, then choose a Load Type, either Regular or Special. If Regular, User must input the account to be loaded. If Special, User choose from the list of Special Promo of the Network. Then press the Top-Up button.","The Mobile Networks available are GLOBE, SMART and SUN.","Go to Settings and click support or visit www.budgetload.com and click LOST PHONE menu. Click submit button, email verification for account recovery will be sent to your email address.","Go to Stock Transfer menu and input the target number and amount to be transfered.","Go to Settings and click DEACTIVATE. Account cannot be deactivated if it still have available creadits.","To keep track of the purchase of Credits, User can go to Transactions and press the Purchase tab. This is where all the purchases of the User is found. 10 transactions will only be displayed.","To know if the trasactions is succesful or not, go to Transaction and press the Top-Up Transaction tab. If the transaction is in the list of Top-Ups, then it is either successful or failed but if its not in the list, then the trasactions is [either failed or] still on process. 10 transactions will only be displayed.","User can go to Transactions and press either Top-Up or Purchase tab. Click View More text found at the bottom of the list. Then an email containing a redirection link will be sent to the User's email address. By clicking the link, it will redirect to the report view of the transactions. This is only applicable for Users with verified email address.","       "]
    
    var selectedIndexPath = -1
    @IBOutlet weak var tblFaqs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "FAQ's"
       tblFaqs.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return about.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FAQsCell") as! FAQsCell
        
        cell.lblTitle.text = about[indexPath.row]
        cell.lblDetails.text = details[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(selectedIndexPath == indexPath.row){
            selectedIndexPath = -1
        }else{
            selectedIndexPath = indexPath.row
        }
        
      
        tblFaqs.beginUpdates()
        tblFaqs.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tblFaqs.endUpdates()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if selectedIndexPath == indexPath.row{
            return getSizeOfRow(selectedIndexPath)
        }else{
            return 50
        }
        
        
        
    }
    
    func getSizeOfRow(size: Int) -> CGFloat{
        var  s:CGFloat = 30
        
        switch size {
        case 0:
            s = 150
            break
        case 1:
            s = 370
            break
        case 2:
            s = 200
            break
        case 3:
            s = 150
            break
        case 4:
            s = 250
            break
        case 5:
            s = 120
            break
        case 6:
            s = 200
            break
        case 7:
            s = 120
            break
        case 8:
            s = 200
            break
            
        case 9:
            s = 200
            break
        case 10:
            s = 300
            break
        case 11:
            s = 300
            break
        default:
            s = 30
            break
            
        }
        return s
    }

}
