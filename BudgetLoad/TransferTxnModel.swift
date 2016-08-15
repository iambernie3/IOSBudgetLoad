//
//  TransferTxnModel.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 08/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import Foundation

class TransferTxnModel: NSObject{

    var ID:Int                  = Int()
    var DateTime: String        = String()
    var SubDistributor:String   = String()
    var Retailer:String         = String()
    var Amount: String          = String()
    var RetailerPrevStock: String   = String()
    var RetailerPrevConsumed: String = String()
    var RetailerPrevAvailable: String = String()
    var PreBalance: String      = String()
    var PostBalance: String     = String()
    var TxnID: String           = String()
    var SenderCommunity:String  = String()
    var ReceiverCommunity:String    = String()
    var ReceiverName:String     = String()

}