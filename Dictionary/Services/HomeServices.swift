//
// Created by Rocky on 2017/5/25.
// Copyright (c) 2017 Rocky. All rights reserved.
//

import Foundation
import RxSwift

class HomeServices{

    func requestData(string:String) -> Observable<WordModel> {
        
        return dictionaryAPI.request(.query(target: string))
            .asObservable()
            .mapJSON()
            .mapToObjectWithNoError(modelTypeL: WordModel.self)
        
    }
}
