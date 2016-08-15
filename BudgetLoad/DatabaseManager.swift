//
//  DatabaseManager.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 05/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import Foundation


class DatabaseManager {

     static let sharedInstance = DatabaseManager()
    
    
    let tblTopUpTxn = "CREATE TABLE IF NOT EXISTS TopUpTxn (ID INTEGER PRIMARY KEY AUTOINCREMENT,Network TEXT,DateTime TEXT, SourceMobTel TEXT, TargetMobTel TEXT, ProductCode TEXT, Amount TEXT, TxnNo TEXT, Status TEXT, ProductDescription TEXT, Discount TEXT,PrevBalance TEXT, PostBalance TEXT, BudgetLoadRefNo TEXT )"
    
    
    let tblPurchaseTxn = "CREATE TABLE IF NOT EXISTS PurchaseTxn (ID INTEGER PRIMARY KEY AUTOINCREMENT,DateTime TEXT, ReferenceNo TEXT, TerminalID TEXT, Amount TEXT, TxnStatus TEXT)"
    
    
    let tblTransferTxn = "CREATE TABLE IF NOT EXISTS TransferTxn (ID INTEGER PRIMARY KEY AUTOINCREMENT,DateTime TEXT, SubDistributor TEXT, Retailer TEXT, Amount TEXT, RetailerPrevStock TEXT,RetailerPrevConsumed TEXT,RetailerPrevAvailable TEXT, PreBalance TEXT,PostBalance TEXT,TxnID TEXT,SenderCommunity TEXT,ReceiverCommunity TEXT,ReceiverName TEXT)"
    
    
    func getpath()-> String{
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("BudgetLoadTransaction2016.db")
        
        return fileURL.path!
    }
    
    func deleteDB() {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("BudgetLoadTransaction2016.db")
        fileURL.removeAllCachedResourceValues()
    }
    func  db() -> FMDatabase {
        return FMDatabase(path: self.getpath())
    }
    
    func createtable(){
        print("\(getpath())")
        let d = db()
        if d.open(){
            d.executeStatements(tblTopUpTxn)
            d.executeStatements(tblPurchaseTxn)
            d.executeStatements(tblTransferTxn)
            
        }
        //d.close()
    }

    //  ***************************************************
    //  Top Up Transaction
    //  ***************************************************
    
    func insertTopTxn(tutModel: TopUpTransactionModel)-> Bool{
        
        let DateTime:String!        = tutModel.DateTime
        let SourceMobTel:String!    = tutModel.SourceMobTel
        let TargetMobTel:String!    = tutModel.TargetMobTel
        let ProductCode:String!     = tutModel.ProductCode
        let Amount:String!          = tutModel.Amount
        let TxnNo:String!           = tutModel.TxnNo
        let Status: String!         = tutModel.Status
        let ProductDescription:String!  = tutModel.ProductDescription
        let Discount:String!            = tutModel.Discount
        let PrevBalance:String!         = tutModel.PrevBalance
        let PostBalance:String!         = tutModel.PostBalance
        let BudgetLoadRefNo:String!     = tutModel.BudgetLoadRefNo
        let network:String!             = NSUserDefaults.standardUserDefaults().stringForKey(IdentifierName.productNetwork)
        
        let sql_stmt = "INSERT INTO TopUpTxn(Network,DateTime,SourceMobTel,TargetMobTel,ProductCode,Amount,TxnNo, Status,ProductDescription,Discount,PrevBalance,PostBalance,BudgetLoadRefNo) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"
        
        let d = db()
        d.open()
        let isInserted = d.executeUpdate(sql_stmt, withArgumentsInArray: [network,DateTime,SourceMobTel,TargetMobTel,ProductCode,Amount,TxnNo,Status,ProductDescription,Discount,PrevBalance,PostBalance,BudgetLoadRefNo])
        
        return isInserted
    }
    
    func ifTopTxnNoExist(txn:String)-> Bool{
        
        var val:Bool = false
        let sql_stmt = "SELECT TxnNo FROM TopUpTxn";
        let d = db()
        
       d.open()
        
        
       let resultSet: FMResultSet! = d.executeQuery(sql_stmt, withArgumentsInArray: nil)
        if (resultSet != nil) {
            while resultSet.next() {
                let txnNo = resultSet?.stringForColumn("TxnNo")
                if txnNo == txn {
                    val = true
                    
                    break
                }
                
            }
        }
       
        return val
        
    }
    
    func getAllTopUpTxn()-> NSMutableArray{
        let d = db()
        d.open()
        let resultSet: FMResultSet! = d.executeQuery("SELECT * FROM TopUpTxn", withArgumentsInArray: nil)
        
        let txnInfo : NSMutableArray = NSMutableArray()

        if (resultSet != nil) {
            while resultSet.next() {
                let tutmodel: TopUpTransactionModel = TopUpTransactionModel()
                tutmodel.Network             = resultSet!.stringForColumn("Network")
                tutmodel.DateTime            = resultSet!.stringForColumn("DateTime")
                tutmodel.SourceMobTel        = resultSet!.stringForColumn("SourceMobTel")
                tutmodel.TargetMobTel        = resultSet!.stringForColumn("TargetMobTel")
                tutmodel.ProductCode         = resultSet!.stringForColumn("ProductCode")
                tutmodel.Amount              = String(resultSet!.doubleForColumn("Amount"))
                tutmodel.TxnNo               = resultSet!.stringForColumn("TxnNo")
                tutmodel.Status              = resultSet!.stringForColumn("Status")
                tutmodel.ProductDescription  = resultSet!.stringForColumn("ProductDescription")
                tutmodel.Discount            = resultSet!.stringForColumn("Discount")
                tutmodel.PrevBalance         = resultSet!.stringForColumn("PrevBalance")
                tutmodel.PostBalance         = resultSet!.stringForColumn("PostBalance")
                tutmodel.BudgetLoadRefNo     = resultSet!.stringForColumn("BudgetLoadRefNo")
                tutmodel.ID                  = Int((resultSet!.intForColumn("ID")))
                txnInfo.addObject(tutmodel)
                
            }
        }
        return txnInfo
    }
    
    //**************************************************************
    // Transfer Transaction
    //**************************************************************
    
    func insertTransferTxn(ttxn: TransferTxnModel) -> Bool{
    
        let DateTime    = ttxn.DateTime
        let SubDistributor  = ttxn.SubDistributor
        let Retailer        = ttxn.Retailer
        let Amount          = ttxn.Amount
        let RetailerPrevStock = ttxn.RetailerPrevStock
        let RetailerPrevConsumed = ttxn.RetailerPrevConsumed
        let RetailerPrevAvailable   = ttxn.RetailerPrevAvailable
        let PreBalance      = ttxn.PreBalance
        let PostBalance     = ttxn.PostBalance
        let TxnID           = ttxn.TxnID
        let SenderCommunity = ttxn.SenderCommunity
        let ReceiverCommunity = ttxn.ReceiverCommunity
        let ReceiverName      = ttxn.ReceiverName
        
        let sql_stmt = "INSERT INTO TransferTxn(DateTime,SubDistributor,Retailer,Amount,RetailerPrevStock,RetailerPrevConsumed,RetailerPrevAvailable, PreBalance,PostBalance,TxnID,SenderCommunity,ReceiverCommunity,ReceiverName) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)"
        
        let d = db()
       d.open()
        let isInserted = d.executeUpdate(sql_stmt, withArgumentsInArray: [DateTime,SubDistributor,Retailer,Amount,RetailerPrevStock,RetailerPrevConsumed,RetailerPrevAvailable,PreBalance,PostBalance,TxnID,SenderCommunity,ReceiverCommunity,ReceiverName])
        //d.close()
        return isInserted
    
    }
    
    
    func ifTransferTxnIDExist(TxnID:String)-> Bool{
        
        var val:Bool = false
        let sql_stmt = "SELECT TxnID FROM TransferTxn";
        let d = db()
        d.open()
        
        
        let resultSet: FMResultSet! = d.executeQuery(sql_stmt, withArgumentsInArray: nil)
        if (resultSet != nil) {
            while resultSet.next() {
                let txnNo = resultSet?.stringForColumn("TxnID")
                if txnNo == TxnID {
                    val = true
                    
                    break
                }
                
            }
        }
        //d.close()
        return val
        
    }
    
    func getAllTransferTxn()-> NSMutableArray{
    
        let d = db()
            d.open()
        let resultSet: FMResultSet! = d.executeQuery("SELECT * FROM TransferTxn", withArgumentsInArray: nil)
        let transferArray:NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            while resultSet.next(){
                let txnModel:TransferTxnModel = TransferTxnModel()
                
                txnModel.ID         = Int(resultSet.intForColumn("ID"))
                txnModel.Amount     = resultSet.stringForColumn("Amount")
                txnModel.DateTime   = resultSet.stringForColumn("DateTime")
                txnModel.PostBalance = resultSet.stringForColumn("PostBalance")
                txnModel.PreBalance  = resultSet.stringForColumn("PreBalance")
                txnModel.ReceiverCommunity  = resultSet.stringForColumn("ReceiverCommunity")
                txnModel.ReceiverName       = resultSet.stringForColumn("ReceiverName")
                txnModel.Retailer           = resultSet.stringForColumn("Retailer")
                txnModel.RetailerPrevAvailable  =    resultSet.stringForColumn("RetailerPrevAvailable")
                txnModel.RetailerPrevConsumed   = resultSet.stringForColumn("RetailerPrevAvailable")
                txnModel.RetailerPrevStock      = resultSet.stringForColumn("RetailerPrevStock")
                txnModel.SenderCommunity        = resultSet.stringForColumn("SenderCommunity")
                txnModel.SubDistributor         = resultSet.stringForColumn("SubDistributor")
                txnModel.TxnID                  = resultSet.stringForColumn("TxnID")
                transferArray.addObject(txnModel)
            }
        }
        
            return transferArray
    }
    
    
    //*************************************************
    // Purchase Transaction
    //*************************************************
    
    func insertPurchaseTransaction(PTxnModel: PurchaseTxnModel) -> Bool{
    
        
        let DateTime    = PTxnModel.DateTime
        let ReferenceNo = PTxnModel.ReferenceNo
        let TerminalID  = PTxnModel.TerminalID
        let Amount      = PTxnModel.Amount
        let TxnStatus   = PTxnModel.TxnStatus
        
        let sql_stmt = "INSERT INTO PurchaseTxn(DateTime,ReferenceNo,TerminalID,Amount,TxnStatus) VALUES(?,?,?,?,?)"
        
        let d = db()
        d.open()
        let isInserted = d.executeUpdate(sql_stmt, withArgumentsInArray: [DateTime,ReferenceNo,TerminalID,Amount,TxnStatus])
        //d.close()
        return isInserted
    }
    
    
    func isPurchaseTxnExist(referenceID: String) -> Bool{
        var val:Bool = false
        
        let d = db()
        d.open()
        
        let resultSet:FMResultSet! = d.executeQuery("SELECT ReferenceNo FROM PurchaseTxn", withArgumentsInArray: nil)
        
        if(resultSet != nil){
        
            while resultSet.next(){
            
                let ref = resultSet.stringForColumn("ReferenceNo")
                
                if ref == referenceID {
                    val = true
                    print("Ref : \(ref)")
                    break;
                }
                
            }
        }
        
        return val
    }
    
    func getAllPurchaseTxn()->NSMutableArray{
        let d = db()
            d.open()
        let resultSet:FMResultSet! = d.executeQuery("SELECT * FROM PurchaseTxn", withArgumentsInArray: nil)
        let purchaseArray: NSMutableArray = NSMutableArray()
        if (resultSet != nil){
            while resultSet.next(){
                
                let purchaseModel:PurchaseTxnModel = PurchaseTxnModel()
                
                purchaseModel.Amount    = resultSet!.stringForColumn("Amount")
                purchaseModel.DateTime  = resultSet!.stringForColumn("DateTime")
                purchaseModel.ReferenceNo = resultSet.stringForColumn("ReferenceNo")
                purchaseModel.TerminalID  = resultSet!.stringForColumn("TerminalID")
                purchaseModel.TxnStatus   = resultSet!.stringForColumn("TxnStatus")
                purchaseArray.addObject(purchaseModel)
            }
        }

        return purchaseArray
    }
}













