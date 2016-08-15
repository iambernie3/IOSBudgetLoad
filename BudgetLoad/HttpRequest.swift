//
//  HttpRequest.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 01/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias Callback = (String?) -> Void
typealias Callback2 = (NSDictionary?) -> Void

let defaults = NSUserDefaults.standardUserDefaults()

public class HttpRequest{
    
    //======================================================================================
    //  Create Session / Get session id
    //======================================================================================
    
    class func createSession() -> Void {
        let imei: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let key: String             = IdentifierName.session_id
        let tempstr:String          = (imei.lowercaseString) + "C R E A T E  S E S S I O N"
        let authcode:String         = String(tempstr.sha1())
        
        
        let params =  ["IMEI":imei,
                       "id":IdentifierName.id,
                       "AuthCode":authcode]
        
        
        Alamofire.request(.POST, UrlVariable.SESSIONURL,parameters:params).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    let id = json["Session"]["SessionID"]
                    if id != "" {
                        let sessionid: String = String(id)
                        defaults.setObject(sessionid, forKey: key)
                        defaults.synchronize()
                    }
                    
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //======================================================================================
    //  Register Number
    //======================================================================================
    
    class func registerNumber(completion: Callback) -> Void{
        
        
        let imei: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel:String     = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let sessionID:String        = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID:String        = defaults.stringForKey(IdentifierName.partnerID)!
        let REFERRER: String        = defaults.stringForKey(IdentifierName.referrer)!
        
        let tmpStr:String           = (imei.lowercaseString) + SourceMobTel + "R E G I S T E R" + (sessionID.lowercaseString)
        let authcode:String         = tmpStr.sha1()
        
        
        let params =  ["IMEI":imei,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": sessionID,
                       "PartnerID": PartnerID,
                       "REFERRER":REFERRER,
                       "AuthCode":authcode,
                       "id":IdentifierName.id]
        
        Alamofire.request(.POST,UrlVariable.REGISTERURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["Register"]["ResultCode"]
                        completion(String(resultCode))
                        print("Register Number: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
        
    }
    
    //======================================================================================
    //  Verify Code
    //======================================================================================
    
    class func verifyCode(verificationCode:String, completion: Callback){
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let VCode: String           = verificationCode   //defaults.stringForKey(IdentifierName.verificationCode)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "V E R I F Y  C O D E" + (SessionNo.lowercaseString) + VCode
        
        let AuthCode: String        = tmpStr.sha1()
        
        let str: String = "\(SourceMobTel) \(SessionNo) \(VCode) \(AuthCode) \(IdentifierName.id    )"
        print("verify: \(str)")
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "VCode": VCode,
                       "AuthCode":AuthCode,
                       "id":IdentifierName.id]
        
        Alamofire.request(.POST,UrlVariable.VERIFYURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["Verify"]["Result"]
                        completion(String(resultCode))
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  GET WALLET BALANCE
    //======================================================================================
    
    
    class func walletBalance(completion: Callback2){
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let VersionCode: String     = App.appVersion
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "G E T  W A L L E T  B A L A N C E" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        //let str = "\(SourceMobTel) \(SessionNo) \(AuthCode) \(VersionCode) \(PartnerID)  \(IdentifierName.id)"
        //print("\(str)")
        
        let params =  ["IMEI"           :IMEI,
                       "SourceMobTel"   :SourceMobTel,
                       "SessionNo"      :SessionNo,
                       "AuthCode"       :AuthCode,
                       "VersionCode"    :VersionCode,
                       "PartnerID"      :PartnerID,
                       "id"             :IdentifierName.id]
        
        Alamofire.request(.POST,UrlVariable.BALANCEURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode  = json["WalletBalance"]["ResultCode"]
                        let Credits     = json["WalletBalance"]["Credits"]
                        
                        let dic:NSDictionary = [
                            "ResultCode" : "\(resultCode)",
                            "Credits": "\(Credits)"
                        ]
                        
                        completion(dic)
                        //print("WALLET: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  UPDATE PROFILE
    //======================================================================================
    
    
    class func updateProfile(info: NSDictionary, completion: Callback){
        
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let LName: String           = info.objectForKey("lname") as! String
        let FName: String           = info.objectForKey("fname") as! String
        let MName: String           = info.objectForKey("mname") as! String
        let Address: String         = info.objectForKey("address") as! String
        let Email: String           = info.objectForKey("email") as! String
        let BirthDate:String        = info.objectForKey("birthday") as! String
        let Gender:String           = info.objectForKey("gender") as! String
        let Occupation:String       = info.objectForKey("occupation") as! String
        let Interest:String         = info.objectForKey("interest") as! String
        let GroupCode:String        = info.objectForKey("group") as! String
        let DealerType:String       = info.objectForKey("dealerType") as! String
        let Referrer:String         = info.objectForKey("referrer") as! String
        let VersionCode: String     = App.appVersion
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "U P D A T E  P R O F I L E" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        //print("update: \(IMEI) \(SourceMobTel) \(SessionNo) \(AuthCode) \(VersionCode) \(PartnerID) \(IdentifierName.id)")
        
        let params =  ["IMEI"           :IMEI,
                       "SourceMobTel"   :SourceMobTel,
                       "SessionNo"      :SessionNo,
                       "AuthCode"       :AuthCode,
                       "LName"          :LName,
                       "FName"          :FName,
                       "MName"          :MName,
                       "Address"        :Address,
                       "Email"          :Email,
                       "BirthDate"      :BirthDate,
                       "Gender"         :Gender,
                       "Occupation"     :Occupation,
                       "Interest"       :Interest,
                       "GroupCode"      :GroupCode,
                       "DealerType"     :DealerType,
                       "Referrer"       :Referrer,
                       "VersionCode"    :VersionCode,
                       "PartnerID"      :PartnerID,
                       "id"             :IdentifierName.id]
        
        Alamofire.request(.POST,UrlVariable.UPDATEURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let UpdateProfile = json["UpdateProfile"]["Result"]
                        completion(String(UpdateProfile))
                        //print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  GET PROFILE
    //======================================================================================
    
    class func getProfile(completion: Callback2){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "G E T  P R O F I L E" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        //let str = "\(SourceMobTel) \(SessionNo) \(AuthCode) \(PartnerID) \(IdentifierName.id)"
        //print("params : \(str)")
        
        
        let params =  ["IMEI"           : "\(IMEI)",
                       "SourceMobTel"   : "\(SourceMobTel)",
                       "SessionNo"      : "\(SessionNo)",
                       "AuthCode"       : "\(AuthCode)",
                       "PartnerID"      : "\(PartnerID)",
                       "id"             : "\(IdentifierName.id)"]
        
        Alamofire.request(.POST,UrlVariable.PROFILEURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //print("get profile \(json)")
                        let groupCode   = json["Profile"]["GroupCode"]
                        let Email       = json["Profile"]["Email"]
                        let Referrer    = json["Profile"]["Referrer"]
                        let DealerType  = json["Profile"]["DealerType"]
                        let FirstName   = json["Profile"]["FirstName"]
                        let Occupation  = json["Profile"]["Occupation"]
                        let Address     = json["Profile"]["Address"]
                        let Gender      = json["Profile"]["Gender"]
                        let BirthDate   = json["Profile"]["BirthDate"]
                        let MiddleName  = json["Profile"]["MiddleName"]
                        let Interest    = json["Profile"]["Interest"]
                        let LastName    = json["Profile"]["LastName"]
                        let Result      = json["Profile"]["Result"]
                        
                        let dic:NSDictionary = [
                            "GroupCode" :"\(groupCode)",
                            "Email"     :"\(Email)",
                            "Referrer"  :"\(Referrer)",
                            "DealerType":"\(DealerType)",
                            "FirstName" :"\(FirstName)",
                            "Occupation":"\(Occupation)",
                            "Address"   :"\(Address)",
                            "Gender"    :"\(Gender)",
                            "BirthDate" :"\(BirthDate)",
                            "MiddleName":"\(MiddleName)",
                            "Interest"  :"\(Interest)",
                            "LastName"  :"\(LastName)",
                            "Result"    :"\(Result)"
                        ]
                        
                        completion(dic)
                        //print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    //======================================================================================
    //  SYNCHRONIZE PRODUCT SIGNATURE
    //======================================================================================
    
    class func synchronizeProductSignature(completion: Callback){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "G E T  S I G N A T U R E" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id]
        
        Alamofire.request(.POST,UrlVariable.PRODUCTSYNCURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //let resultCode = json["Register"]["ResultCode"]
                        //completion(String(resultCode))
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    //======================================================================================
    //  Top-Up Load
    //======================================================================================
    
    class func topUpLoad(topUp:NSDictionary, completion: Callback){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "T O P U P  L O A D" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let TargetMobTel: String    = topUp.objectForKey("TargetMobTel") as! String
        let ProductCode: String     = topUp.objectForKey("ProductCode") as! String
        let Amount: String          = topUp.objectForKey("Amount") as! String
        let Longitude: String       = topUp.objectForKey("Longitude") as! String
        let Latitude:String         = topUp.objectForKey("Latitude") as! String
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "TargetMobTel":TargetMobTel,
                       "ProductCode":ProductCode,
                       "Amount":Amount,
                       "Longitude": Longitude,
                       "Latitude": Latitude
        ]
        
        Alamofire.request(.POST,UrlVariable.LOADURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["TopUp"]["ResultCode"]
                        completion(String(resultCode))
                        //print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    //======================================================================================
    //  Commit Top-Up
    //======================================================================================
    
    class func commitTopUp(referenceNo: String,targetMobTel:String, completion: Callback){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "C O M M I T  T O P U P" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let TargetMobTel: String    = targetMobTel
        let ReferenceNo: String     = referenceNo
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "TargetMobTel":TargetMobTel,
                       "ReferenceNo": ReferenceNo
            
        ]
        
        Alamofire.request(.POST,UrlVariable.COMMITURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //let resultCode = json["Register"]["ResultCode"]
                        //completion(String(resultCode))
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    //======================================================================================
    //  Stock Transfer
    //======================================================================================
    
    class func stockTransfer(amount: String,targetMobTel:String,partnerID:String, completion: Callback){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "S T O C K  T R A N S F E R" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let TargetMobTel: String    = targetMobTel
        let Amount: String          = amount
        let params =  [
            "IMEI"           :IMEI,
            "SourceMobTel"   :SourceMobTel,
            "SessionNo"      :SessionNo,
            "AuthCode"       :AuthCode,
            "PartnerID"      :PartnerID,
            "id"             :IdentifierName.id,
            "TargetMobTel"   :TargetMobTel,
            "Amount"         : Amount,
            "TARGETPARTNERID" : partnerID
            
        ]
        //print("stock transfer params : \(params)")
        
        Alamofire.request(.POST,UrlVariable.STOCKTRANSFER,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["StockTransfer"]["ResultCode"]
                        completion(String(resultCode))
                        //print("Stock Transfer: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    
    
    //======================================================================================
    //  get Target partner id (Stock Transfer)
    //======================================================================================
    
    //    String apiURL = OTHERSURL +
    //"id=d6b27ee9de22e000700f0163e662ecba1d201c99
    //CMD=RECEIVERCOMMUNITY
    //IMEI=" + imei + "
    //TargetMobile="+targetmobile+"
    //PartnerID="+PartnerID+"
    //SourceMobile="+mobile+"";
    
    class func getTargetPartnerID(targetMobTel:String, completion: Callback){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        
        let params =  ["IMEI"           :IMEI,
                       "SourceMobTel"   :SourceMobTel,
                       "PartnerID"      :PartnerID,
                       "id"             :IdentifierName.id,
                       "TargetMobile"   :targetMobTel,
                       "CMD"            :"RECEIVERCOMMUNITY"]
        
        print("params partner id : \(params)")
        
        Alamofire.request(.POST,UrlVariable.OTHERSURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //print("partner : \(json[1])")
                        if json.count > 1 {
                            
                            let partner_id = json[1]
                            let id = partner_id["Community"][0]["NetworkID"]
                            //print("partner id : \(id)")
                            completion(String(id))
                        }
                        
                        
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
        
        
    }
    
    //======================================================================================
    //  Commit Stock Transfer
    //======================================================================================
    
    
    class func commitStockTransfer(referenceNo: String,targetMobTel:String, completion: Callback){
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "C O M M I T  S T O C K  T R A N S F E R" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let TargetMobTel: String    = targetMobTel
        let ReferenceNo: String     = referenceNo
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "TargetMobTel":TargetMobTel,
                       "ReferenceNo": ReferenceNo
            
        ]
        
        Alamofire.request(.POST,UrlVariable.COMMITSTOCKTRANSFER,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //let resultCode = json["Register"]["ResultCode"]
                        //completion(String(resultCode))
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    //======================================================================================
    //  Get TOP-UP Transaction
    //======================================================================================
    
    class func getTopUpTransaction(completion: Callback){
        
        var jsonNSData: AnyObject!
        let sharedInstance = DatabaseManager()
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "T O P U P  T R A N S A C T I O N" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let Network: String         = defaults.stringForKey(IdentifierName.productNetwork)!
        
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "Network":Network,
                       ]
        
        //print("topup trnx: \(params)")
        
        Alamofire.request(.POST,UrlVariable.TXNHISTURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let count = json.count
                        if count > 1 {
                            
                            defaults.setBool(true, forKey: IdentifierName.hasTopUpTxn)
                            let jsonStr = "\(json[1]["TopUpData"])"
                            let data:NSData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)!
                            //print("top up txn : \(jsonStr)")
                            
                            do{
                                jsonNSData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                            }catch{
                                print(error)
                            }
                            
                            for i in 0..<jsonNSData.count{
                                
                                let txnNo = jsonNSData[i]["TxnNo"] as! String
                                
                                let tutmodel: TopUpTransactionModel = TopUpTransactionModel()
                                tutmodel.ID           = 0
                                tutmodel.Amount       = jsonNSData[i]["Amount"] as! String
                                tutmodel.DateTime     = jsonNSData[i]["DateTime"] as! String
                                tutmodel.SourceMobTel = jsonNSData[i]["SourceMobTel"] as! String
                                tutmodel.TargetMobTel = jsonNSData[i]["TargetMobTel"] as! String
                                tutmodel.ProductCode  = jsonNSData[i]["ProductCode"] as! String
                                tutmodel.TxnNo        = jsonNSData[i]["TxnNo"] as! String
                                tutmodel.Status       = jsonNSData[i]["Status"] as! String
                                tutmodel.ProductDescription      = jsonNSData[i]["ProductDescription"] as! String
                                tutmodel.Discount                = jsonNSData[i]["Discount"] as! String
                                tutmodel.PrevBalance             = jsonNSData[i]["PrevBalance"] as! String
                                tutmodel.PostBalance             = jsonNSData[i]["PostBalance"] as! String
                                tutmodel.BudgetLoadRefNo         = jsonNSData[i]["BudgetLoadRefNo"] as! String
                                
                                
                                let exist = sharedInstance.ifTopTxnNoExist(txnNo)
                                
                                print("== \(exist)")
                                if !exist{
                                    let inserted:Bool = sharedInstance.insertTopTxn(tutmodel)
                                    print("inserted : \(inserted)")
                                }else{
                                    print("exist")
                                }
                                
                            }
                            
                            
                        }else{
                            NSUserDefaults.standardUserDefaults().setBool(false, forKey: IdentifierName.hasTopUpTxn)
                        }
                        
                        
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  Get Stock Transfer Transaction
    //======================================================================================
    
    class func getStockTransferTransaction(completion: Callback){
        
        let sharedInstance = DatabaseManager()
        var jsonNSData: AnyObject!
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "S T O C K  T R A N S F E R  T R A N S A C T I O N" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       ]
        
        
        Alamofire.request(.POST,UrlVariable.STOCKTRANSFERHISTORY,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let count = json.count
                        
                        if count > 1 {
                            
                            defaults.setBool(true, forKey: IdentifierName.hasTransferTxn)
                            let jsonStr = "\(json[1]["StockTransferData"])"
                            let data:NSData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)!
                            
                            
                            do{
                                jsonNSData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                            }catch{
                                print(error)
                            }
                            
                            
                            for i in 0..<jsonNSData.count{
                                
                                let txnNo = jsonNSData[i]["TxnID"] as! String
                                
                                let ttxnmodel: TransferTxnModel = TransferTxnModel()
                                ttxnmodel.ID                        = 0
                                ttxnmodel.Amount                    = jsonNSData[i]["Amount"] as! String
                                ttxnmodel.DateTime                  = jsonNSData[i]["DateTime"] as! String
                                ttxnmodel.SubDistributor            = jsonNSData[i]["SubDistributor"] as! String
                                ttxnmodel.Retailer                  = jsonNSData[i]["Retailer"] as! String
                                ttxnmodel.RetailerPrevStock         = jsonNSData[i]["RetailerPrevStock"] as! String
                                ttxnmodel.RetailerPrevConsumed      = jsonNSData[i]["RetailerPrevConsumed"] as! String
                                ttxnmodel.RetailerPrevAvailable     = jsonNSData[i]["RetailerPrevAvailable"] as! String
                                ttxnmodel.PreBalance                = jsonNSData[i]["PreBalance"] as! String
                                ttxnmodel.PostBalance               = jsonNSData[i]["PostBalance"] as! String
                                ttxnmodel.TxnID                     = jsonNSData[i]["TxnID"] as! String
                                ttxnmodel.SenderCommunity           = jsonNSData[i]["SenderCommunity"] as! String
                                ttxnmodel.ReceiverCommunity         = jsonNSData[i]["ReceiverCommunity"] as! String
                                ttxnmodel.ReceiverName              = jsonNSData[i]["ReceiverName"] as! String
                                
                                let exist = sharedInstance.ifTransferTxnIDExist(txnNo)
                                
                                if !exist{
                                    sharedInstance.insertTransferTxn(ttxnmodel)
                                    
                                }else{
                                    print("exist")
                                }
                                
                            }
                            
                        }else{
                            //NSUserDefaults.standardUserDefaults().setBool(false, forKey: IdentifierName.hasTransferTxn)
                        }
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  Get Purchases
    //======================================================================================
    class func getPurchaseTransaction(completion: Callback){
        
        var jsonNSData:AnyObject!
        let sharedInstance = DatabaseManager()
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "P U R C H A S E  T R A N S A C T I O N" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       ]
        //print("purchase \(params)")
        Alamofire.request(.POST,UrlVariable.PURCHASEURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        var json = JSON(value)
                        let count = json.count
                        
                        
                        if count > 1 {
                            
                            defaults.setBool(true, forKey: IdentifierName.hasPurchaseTxn)
                            
                            let jsonStr = "\(json[1]["PurchaseData"])"
                            //print("purchase txn: \(jsonStr)")
                            let data:NSData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)!
                            
                            
                            do{
                                jsonNSData = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                                
                                
                            }catch{
                                print(error)
                            }
                            
                            for i in 0..<jsonNSData.count{
                                let ReferenceNo = jsonNSData[i]["ReferenceNo"] as! String
                                
                                let PTxnModel: PurchaseTxnModel = PurchaseTxnModel()
                                PTxnModel.DateTime    = jsonNSData[i]["DateTime"] as! String
                                PTxnModel.ReferenceNo = jsonNSData[i]["ReferenceNo"] as! String
                                PTxnModel.TerminalID  = jsonNSData[i]["TerminalID"] as! String
                                PTxnModel.Amount      = jsonNSData[i]["Amount"] as! String
                                PTxnModel.TxnStatus   = jsonNSData[i]["TxnStatus"] as! String
                                
                                let exist = sharedInstance.isPurchaseTxnExist(ReferenceNo)
                                
                                if !exist{
                                    
                                    sharedInstance.insertPurchaseTransaction(PTxnModel)
                                }
                                
                            }
                            
                            
                        }else{
                            NSUserDefaults.standardUserDefaults().setBool(false, forKey: IdentifierName.hasPurchaseTxn)
                        }
                        
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  Deactivate Account
    //======================================================================================
    
    class func deactivateAccount(completion: Callback){
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "D E A C T I V A T E" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       ]
        
        Alamofire.request(.POST,UrlVariable.DEACTIVATE,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["DeactivateAccount"]["Message"]
                        completion(String(resultCode))
                        //print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  Send Notification
    //======================================================================================
    
    class func sendNotification(txnType: String,email:String, completion: Callback){
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "M O R E  T R A N S A C T I O N" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let TxnType: String         = txnType
        let Email: String           = email
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "TxnType": TxnType,
                       "Email": Email
        ]
        
        print("noti params \(params)")
        Alamofire.request(.POST,UrlVariable.NOTIFICATION,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //let resultCode = json["Register"]["ResultCode"]
                        //completion(String(resultCode))
                        print("notification: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  Get Dealer Type
    //======================================================================================
    
    class func getDealerType(completion: Callback){
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "M I S C E L L A N E O U S" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "cmd": "DEALERTYPE"
        ]
        
        Alamofire.request(.POST,UrlVariable.OTHERSURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //let resultCode = json["Register"]["ResultCode"]
                        //completion(String(resultCode))
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  Get Group Code
    //======================================================================================
    
    class func getGroupCode(completion: Callback){
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "M I S C E L L A N E O U S" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "cmd": "GROUPCODE"
            
        ]
        
        Alamofire.request(.POST,UrlVariable.OTHERSURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        //let resultCode = json["Register"]["ResultCode"]
                        //completion(String(resultCode))
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  File Ticket
    //======================================================================================
    
    class func fileTicket(fName:String,lName:String, completion: Callback){
        
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = defaults.stringForKey(IdentifierName.session_id)!
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "M I S C E L L A N E O U S" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let cmd: String             = "FILETICKET"
        let FirstName:String        = fName
        let LastName:String         = lName
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "cmd": cmd,
                       "FirstName":FirstName,
                       "LastName":LastName
            
        ]
        
        Alamofire.request(.POST,UrlVariable.OTHERSURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["Ticketing"]["Result"]
                        completion(String(resultCode))
                        
                        //print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //======================================================================================
    //  File Ticket
    //======================================================================================
    
    class func changePassword(pw:String,completion: Callback){
//        String text;
//        shaPass = GlobalFunctions.getSha1Hex(passval);
//        try{
//            String authcode = GlobalFunctions.getSha1Hex(imei.toLowerCase()+ mobile+ "M I S C E L L A N E O U S"+ SessionID.toLowerCase());
//            String apiURL = Constant.OTHERSURL+ "id=d6b27ee9de22e000700f0163e662ecba1d201c99&IMEI="+ imei + "&SourceMobTel="+ mobile + "&SessionNo="+ SessionID.toLowerCase() + "&AuthCode=" + authcode
//                + "&PartnerID=" + PartnerID + "&CMD=SETUPPASSWORD&Password="+ shaPass;
        
        
        let shaPass = pw.sha1()
        let sessionIDLowerCase = defaults.stringForKey(IdentifierName.session_id)!
        
        let IMEI: String            = defaults.stringForKey(IdentifierName.applicationIdentifier)!
        let SourceMobTel: String    = defaults.stringForKey(IdentifierName.sourceMobTel)!
        let SessionNo: String       = sessionIDLowerCase.lowercaseString
        let PartnerID: String       = defaults.stringForKey(IdentifierName.partnerID)!
        let tmpStr: String          = (IMEI.lowercaseString) + SourceMobTel + "M I S C E L L A N E O U S" + (SessionNo.lowercaseString)
        let AuthCode: String        = tmpStr.sha1()
        let cmd: String             = "SETUPPASSWORD"
        let Password:String         = shaPass
        
        let params =  ["IMEI":IMEI,
                       "SourceMobTel":SourceMobTel,
                       "SessionNo": SessionNo,
                       "AuthCode":AuthCode,
                       "PartnerID":PartnerID,
                       "id":IdentifierName.id,
                       "CMD": cmd,
                       "Password": Password
            
        ]
        
        print("password params: \(params)")
        
        Alamofire.request(.POST,UrlVariable.OTHERSURL,parameters: params)
            .validate()
            .responseJSON{
                response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let resultCode = json["PasswordSetup"]["Result"]
                        completion(String(resultCode))
                        
                        print("JSON: \(json)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
}










