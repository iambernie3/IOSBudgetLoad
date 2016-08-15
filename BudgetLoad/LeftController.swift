//
//  LeftController.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 7/20/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class LeftController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblLogo: UILabel!
    
    
    @IBOutlet weak var lblProfileName: UILabel!
    var menuItems:[String] = []   //= ["Notification","Top-Up","Stock Transfer","Contacts","Transactions","Settings","Profile"," "," "," "," "]
    var arrayMenuIcon:[String] = []  //= ["notificationsicon","topup","transfer","profile","transactions","settings","profile"," "," "," "," "]
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceuse = DeviceType.IS_IPHONE_4_OR_LESS
        
        if deviceuse{
                menuItems = ["Notification","Sell Load","Transfer Credits","Contacts","Transactions","Settings","Profile"," "," "," "," "]
                arrayMenuIcon = ["notificationsicon","topup","transfer","profile","transactions","settings","profile"," "," "," "," "]
        }else{
        
            menuItems = ["Notification","Sell Load","Transfer Credits","Contacts","Transactions","Settings","Profile"]
            arrayMenuIcon = ["notificationsicon","topup","transfer","profile","transactions","settings","profile"]
        }
        
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColorFromRGB(0x425274)
        
        lblLogo.layer.borderWidth = 1
        lblLogo.layer.cornerRadius = 35
        lblLogo.layer.masksToBounds = true
        
        
        let name = userDefaults.stringForKey(IdentifierName.profileName)
        
        if name != nil{
            let index = name!.startIndex.advancedBy(0)
            let p_name = name![index]
            lblProfileName.text = name
            lblLogo.text        = String(p_name)
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return menuItems.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let mycell =  tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! CustomTableCell
        
        
        
        mycell.menuItemLabel.text = menuItems[indexPath.row]
        mycell.menuItemIcon.image = UIImage(named: arrayMenuIcon[indexPath.row])
        mycell.backgroundColor = UIColorFromRGB(0x425274)
        mycell.preservesSuperviewLayoutMargins = false
        mycell.separatorInset = UIEdgeInsetsZero
        mycell.layoutMargins = UIEdgeInsetsZero
        
        return mycell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColorFromRGB(0x2C3B5A)
        
        
        
        switch(indexPath.row){
            
        case 0:
            
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as!NotificationController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            break;
            
        case 1:
            
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TopUpController") as! TopUpController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            
            break;
            
        case 2:
            
            
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("StockTransferController") as! StockTransferController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            
            break;
            
        case 3:
            NSUserDefaults.standardUserDefaults().setObject("contact", forKey: "controller")
            
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContactsController") as! ContactsController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            
            break;
            
        case 4:
            
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TransactionsTabBarController") as! TransactionsTabBarController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            
            break;
            
        case 5:
            
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsController") as! SettingsController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            
            break;
            
        case 6:
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingProfileController") as! SettingProfileController
            
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion:nil)
            
            
            break;
            
            
        default:
            break
            
        }
        
        
        
    }
    
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor =  UIColorFromRGB(0x425274)
        cell?.backgroundColor = UIColorFromRGB(0x425274)
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    
    
    
}
