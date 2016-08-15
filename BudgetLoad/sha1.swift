//
//  sha1.swift
//  BudgetLoad
//
//  Created by Johnry Christian Paduhilao on 01/08/2016.
//  Copyright © 2016 Payvenue. All rights reserved.
//

import Foundation


extension String {
    func sha() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }
}