//
//  String+Extension.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation

extension String{

    var md5: String {
        let str = cString(using: .utf8)
        let strLen = CC_LONG(lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        var hash = ""
        for i in 0..<digestLen {
            hash = hash.appendingFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return hash
    }
    
    var hasEmoji: Bool {
        
        for char in unicodeScalars {
            if 0x1d000 <= char.value && char.value <= 0x1f77f || 0x2100 <= char.value && char.value <= 0x26ff {
                return true
            }
        }
        
        return false
    }
    
    var hasChinese:Bool{
        
        for (_, value) in self.characters.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
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
