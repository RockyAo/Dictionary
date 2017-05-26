//
//  Date+Extension.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation

extension Date{

    static func convertFromString(_ dateStr: String, formatStr: String = "YYYY-MM-dd HH:mm:ss zzz") -> Date? {
        let format = DateFormatter()
        format.dateFormat = formatStr
        return format.date(from: dateStr)
    }
    
    func converToString(byFromat formatStr: String = "YYYY-MM-dd HH:mm:ss zzz") -> String {
        
        let format = DateFormatter()
        format.dateFormat = formatStr
        return format.string(from: self)
    }

}
