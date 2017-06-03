//
//  MoyaObjectMapper+Rx.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/26.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

extension Observable{

    func mapToObject<T:Mappable>(modelType:T.Type) -> Observable<T> {
        
        return self.map({ response in
            
            guard let dict = response as? [String: Any] else {
                throw DictionaryError.mapJsonError
            }
            
        
            guard let errorCode = dict["errorCode"] as? String else{
            
                throw DictionaryError.mapJsonError
            }
            
            
            
            if (errorCode == "0") {
                
                return Mapper<T>().map(JSON: dict)!
                
            } else {
                
                throw DictionaryError.netError(discription: "network can not work")
        
            }
        })
    }
    
    func mapToObjectWithNoError<T:Mappable>(modelType:T.Type) -> Observable<T> {
        
        return self.map({ response in
            
            guard let dict = response as? [String: Any] else {
                throw DictionaryError.mapJsonError
            }
            
//            print(dict)
            
            return Mapper<T>().map(JSON: dict)!
            
        })
    }
}
