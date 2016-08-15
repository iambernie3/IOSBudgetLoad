//
//  ProductModel.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 04/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import Foundation

class ProductModel {

    var Keyword: String!
    var TransactionType:String!
    var Amount:String!
    var Description:String!
    var Discount:String!
    
    
    init(Keyword:String, TransactionType:String, Amount:String,Description:String,Discount:String){
        
        self.Keyword = Keyword
        self.TransactionType = TransactionType
        self.Amount = Amount
        self.Description = Description
        self.Discount = Discount
    
    }

}