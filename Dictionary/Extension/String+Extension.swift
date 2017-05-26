//
//  String+Extension.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation

extension String{

    var MD5: String {
        let cString = self.cString(using: String.Encoding.utf8)
        let length = CUnsignedInt(
            self.lengthOfBytes(using: String.Encoding.utf8)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(
            capacity: Int(CC_MD5_DIGEST_LENGTH)
        )
        
        CC_MD5(cString!, length, result)
        
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15])
    }
    
    var hasEmoji: Bool {
        
        for char in unicodeScalars {
            if 0x1d000 <= char.value && char.value <= 0x1f77f || 0x2100 <= char.value && char.value <= 0x26ff {
                return true
            }
        }
        
        return false
    }
    
    func removeSpaceChars() -> String {
        return self.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    func removeFirstCharacter() -> String {
        return self.substring(from: self.index(after: self.startIndex))
    }
    
}


// MARK: - static method
extension String{

    static func timeSince1970String() -> String {
        
        let date = NSDate.timeIntervalSinceReferenceDate
        
        return "\(date)"
    }

}
