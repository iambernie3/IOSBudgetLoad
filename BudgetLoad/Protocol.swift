//
//  Protocol.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

protocol TopUpProtocol {
    func setContact(number: String,brand: String)
}

protocol StockTransferProtocol {
   
    func setRecipient(phone:String)
}

protocol FileTicketProtocol {
    func setTicket(topic: String)
}

protocol ProductTypeProtocol {
    func setProduct(product:String, amount:String, productCode:String)
}

protocol TopUpModalProtocol{
    func fillTheField(image:String, status:String, datetime:String, mobileNo:String, amount:String,product:String, txnNo:String,
                      preBal:String, postBal:String, discount:String)
}
