//
//  File.swift
//  BudgetLoad
//
//  Created by Andrew Laurien Ruiz Socia on 4/12/16.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

//MARK: Local Array
//var sampleArray :NSArray?

// MARK: Local Constants
//private let setSegeueIdentifier = "segeueToVC"
//private let bookSegueIdentifier   = "segueToHome"

//MARK: Static Variables
struct UrlVariable {
    
    
    //static var IMEI: String!
    
    
    //*******************
    //PRODUCTION
    //*******************
    
    //     static var SESSIONURL = "https://session.budgetload.com/?"
    //     static var PROFILEURL = "https://profile.budgetload.com/?"
    //     static var VERIFYURL = "https://verify.budgetload.com/?"
    //     static var REGISTERURL = "https://register.budgetload.com/?"
    //     static var UPDATEURL = "https://update.budgetload.com/?"
    //     static var LOADURL = "https://load.budgetload.com/?"
    //     static var COMMITURL = "https://commit.budgetload.com/?"
    //     static var TXNHISTURL = "https://txnhist.budgetload.com/?"
    //     static var PURCHASEURL = "https://purchase.budgetload.com/?"
    //     static var PRODUCTURL = "https://product.budgetload.com/?"
    //     static var PRODUCTSYNCURL = "https://sync.budgetload.com/?"
    //     static var BALANCEURL = "https://balance.budgetload.com/?"
    //     static var PREFIXURL = "https://prefix.budgetload.com/?"
    //     static var DEACTIVATE = "https://deactivate.budgetload.com/?"
    //     static var NOTIFICATION = "https://notification.budgetload.com/?"
    //     static var STOCKTRANSFER = "https://transfer.budgetload.com/?"
    //     static var COMMITSTOCKTRANSFER = "https://committransfer.budgetload.com/?"
    //     static var STOCKTRANSFERHISTORY = "https://transfertxnhist.budgetload.com/?"
    //     static var OTHERSURL = "https://misc.budgetload.com/?"
    
    
    //*******************
    //DEVELOPMENT
    //*******************
    
     static var SESSIONURL = "http://dev2-session.budgetload.com:8282/?"
     static var PROFILEURL = "http://dev2-profile.budgetload.com:8282/?"
     static var VERIFYURL = "http://dev2-verify.budgetload.com:8282/?"
     static var REGISTERURL = "http://dev2-register.budgetload.com:8282/?"
     static var UPDATEURL = "http://dev2-update.budgetload.com:8282/?"
     static var LOADURL = "http://dev2-load.budgetload.com:8282/?"
     static var COMMITURL = "http://dev2-commit.budgetload.com:8282/?"
     static var TXNHISTURL = "http://dev2-txnhist.budgetload.com:8282/?"
     static var PURCHASEURL = "http://dev2-purchase.budgetload.com:8282/?"
     static var PRODUCTURL = "http://dev2-product.budgetload.com:8282/?"
     static var PRODUCTSYNCURL = "http://dev2-sync.budgetload.com:8282/?"
     static var BALANCEURL = "http://dev2-balance.budgetload.com:8282/?"
     static var PREFIXURL = "http://dev2-prefix.budgetload.com:8282/?"
     static var DEACTIVATE = "http://dev2-deactivate.budgetload.com:8282/?"
     static var NOTIFICATION = "http://dev2-notification.budgetload.com:8282/?"
     static var STOCKTRANSFER = "http://dev2-transfer.budgetload.com:8282/?"
     static var COMMITSTOCKTRANSFER = "http://dev2-committransfer.budgetload.com:8282/?"
     static var STOCKTRANSFERHISTORY = "http://dev2-transfertxnhist.budgetload.com:8282/?"
     static var OTHERSURL = "http://dev2-misc.budgetload.com:8282?"
    

    
}

struct IdentifierName {
    static var session_id               = "session_id"
    static var applicationIdentifier    = "ApplicationIdentifier"
    
    // app id
    static var id                       = "d6b27ee9de22e000700f0163e662ecba1d201c99"
    
    //mobile number indentifier
    static var sourceMobTel             = "SourceMobTel"
    static var referrer                 = "ReferrerNumber"
    static var verificationCode         = "VerificationCode"
    //community id
    static var partnerID                = "PartnerID"
    static var community                = "Community"
    static var productNetwork           = "ProductNetwork"
    
    //Transaction
    static var hasTopUpTxn              = "HasTopUpTransaction"
    static var hasPurchaseTxn           = "HasPurchaseTransaction"
    static var hasTransferTxn           = "HasTransferTransaction"
    
    static var jsonTnxTopUp             = "topuptxn"
    static var jsonTxnPurchase          = "purchasetxn"
    static var jsonTxnTransfer          = "transfertxn"
    
    
    static var profileName              = "ProfileName"
    static var email                    = "Email"
    static var fName                    = "fName"
    static var lName                    = "lName"
    static var password                 = "Password"
}

struct App {
    static var appVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}

//MARK : enum Constants
//enum AnimationMovement: Int {
//    case Left = 0
//    case Right = 1
//    case Top = 2
//    case Bottom = 3
//}
//class FolderListPage: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //Accessing Local Array
//        sampleArray =  ["1", "2"]
//        print(sampleArray)
//        
//        
//        //Accessing Static Variable
//        let newString = SampleVariables.sampleVariable as String
//        print(newString)
//        
//        //Accessing Local Constants
//        let changedSegueIdentifier = setSegeueIdentifier
//        print(changedSegueIdentifier)
//        
//        //Accessing enum Constants
//        let rightMovement = AnimationMovement.Right.rawValue
//        print (rightMovement)            
//    }
//}