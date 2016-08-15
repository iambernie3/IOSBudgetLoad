//
//  TransactionsTabBarController.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class TransactionsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //fetchTopUpTransaction()
        fetchPurchaseTransaction()
        //fetchStockTransferTransaction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func openDrawer(sender: AnyObject) {
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.centerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    func fetchTopUpTransaction(){
        
        if Reachability.isConnectedToNetwork(){
            HttpRequest.getTopUpTransaction({
                (response:String?) in
                
                
            })
        }
    }
    func fetchPurchaseTransaction(){
        if Reachability.isConnectedToNetwork(){
            HttpRequest.getPurchaseTransaction({
                (response:String?) in
                
                
            })
        }
    }
    func fetchStockTransferTransaction(){
        if Reachability.isConnectedToNetwork(){
            HttpRequest.getStockTransferTransaction({
                (response:String?) in
                
            })
        }
    }

    
  }
