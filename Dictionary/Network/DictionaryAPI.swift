//
//  DictionaryAPI.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/25.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import Moya



let dictionaryAPI = RxMoyaProvider<DictService>()

enum DictService {
    case query(target:String)
}

extension DictService: TargetType {
    
    var baseURL : URL {return URL(string : NetworkMarco.baseUrl)!}
    var path: String {
        switch self {
        case .query(target: _):
            return ""
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .request
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .query(let target):
            //多请求应抽出公共参数
            return ["q":target,"from":"atuo","to":"auto","appKey":NetworkMarco.key,"salt":"0110","sign":"\(NetworkMarco.key)\(target)0110\(NetworkMarco.secrect)".md5]
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var sampleData: Data {
        switch self {
        case .query(_):
            return "{\"data\":{\"id\":\"1001\"},\"meta\":{\"status\":200,\"msg\":\"OK\"}}".data(using: String.Encoding.utf8)!
    
        }
    }
    
}
