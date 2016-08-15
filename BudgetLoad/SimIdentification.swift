//
//  SimIdentification.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 27/07/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import UIKit

class SimIdentification {
    
    let prefix: String = "[{\"Prefix\":\"0905\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0906\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0915\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0916\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0917\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0926\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0927\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0935\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0936\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0937\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0817\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0975\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0977\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0923\", \"Brand\":\"SUN\"},{\"Prefix\":\"0933\", \"Brand\":\"SUN\"},{\"Prefix\":\"0932\", \"Brand\":\"SUN\"},{\"Prefix\":\"0942\", \"Brand\":\"SUN\"},{\"Prefix\":\"0943\", \"Brand\":\"SUN\"},{\"Prefix\":\"0922\", \"Brand\":\"SUN\"},{\"Prefix\":\"0925\", \"Brand\":\"SUN\"},{\"Prefix\":\"0907\", \"Brand\":\"TNT\"},{\"Prefix\":\"0908\", \"Brand\":\"BUDDY\"},{\"Prefix\":\"0909\", \"Brand\":\"TNT\"},{\"Prefix\":\"0910\", \"Brand\":\"TNT\"},{\"Prefix\":\"0912\", \"Brand\":\"TNT\"},{\"Prefix\":\"0918\", \"Brand\":\"BUDDY\"},{\"Prefix\":\"0919\", \"Brand\":\"BUDDY\"},{\"Prefix\":\"0920\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0921\", \"Brand\":\"BUDDY\"},{\"Prefix\":\"0928\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0929\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0930\", \"Brand\":\"TNT\"},{\"Prefix\":\"0939\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0946\", \"Brand\":\"TNT\"},{\"Prefix\":\"0950\", \"Brand\":\"TNT\"},{\"Prefix\":\"0947\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0948\", \"Brand\":\"TNT\"},{\"Prefix\":\"0949\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0998\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0999\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0911\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0931\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0938\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0979\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0989\", \"Brand\":\"BUDDYBRO\"},{\"Prefix\":\"0994\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0996\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0997\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0995\", \"Brand\":\"GLOBE\"},{\"Prefix\":\"0913\", \"Brand\":\"SMART\"},{\"Prefix\":\"0914\", \"Brand\":\"SMART\"}]";
    
    
    
    func parseJson(numberPref: String) -> String{
        
        let data:NSData = prefix.dataUsingEncoding(NSUTF8StringEncoding)!
        var brand: String = ""
        
        var json: AnyObject!
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
        } catch {
            print(error)
        }
        
        for sim in json as! Array<AnyObject>{
            let pref = (sim["Prefix"] as AnyObject? as? String)
            
            if pref == numberPref {
               
                brand = (sim["Brand"] as AnyObject? as? String)!
                return brand
            }
        }
        
        return brand
    }
}