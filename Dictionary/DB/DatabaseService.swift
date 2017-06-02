//
//  DatabaseService.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/29.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import Foundation
import RxRealm
import RealmSwift
import RxSwift

class DatabaseService:DatabaseServiceType{
    

    fileprivate func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            
            return try action(realm)
        } catch let err {
            print("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }
    
    
    /// 入库并自动过滤已存在数据
    ///
    /// - Parameter item: Realm模型
    /// - Returns: Observable<>
    @discardableResult
    func createAndUpdateItem(item: WordDataModel) -> Observable<WordDataModel>{
        
       let result = withRealm("create item") { (realm) -> Observable<WordDataModel> in
        
            let realm = try! Realm()
        
            let dataArray = realm.objects(WordDataModel.self)
                    .toArray()
        
            item.id = dataArray.count + 1
        
            let hasSave = dataArray.filter({ (model) -> Bool in
                
                    if model.name == item.name{
                
                        return true
                    }
                
                    return false
                })
        
        
            if hasSave.count <= 0{
        
                _ = Observable.just(item)
                    .subscribe(realm.rx.add())
            }else{
                
                ///add update = true  会导致多存一个对象。原因未知。
                _ = Observable.just(item)
                    .subscribe{
                        _ = realm.rx.delete()
                        _ = realm.rx.add()
                    }
            }
        
            return .just(item)
       }
        
       return result ?? .error(DatabaseError.creationFaild)
    }
    
    @discardableResult
    func delete(item: WordDataModel) -> Observable<Void> {
        
        let result = withRealm("deleting") { realm-> Observable<Void> in
            try realm.write {
                realm.delete(item)
            }
            return .empty()
        }
        return result ?? .error(DatabaseError.deletionFailed(item))
    }
    
    @discardableResult
    func deleteAll() -> Observable<Void> {
        let result = withRealm("deleting") { realm-> Observable<Void> in
            try realm.write {
                realm.deleteAll()
            }
            return .empty()
        }
        return result ?? .error(DatabaseError.deletionAllFailed)
    }

    ////未知原因导致更新不了数据，该方法
    @discardableResult
    func update(item: WordDataModel, collection: Bool) -> Observable<WordDataModel> {
        
        let result = withRealm("updating collection") { realm -> Observable<WordDataModel> in
            
            let realm = try Realm()
            do{
                
                try realm.write {
                    
                    item.collection = collection
                    
                }
            }catch let error {
            
                print(error)
            }
            return .just(item)
        }
        return result ?? .error(DatabaseError.updateFaild(item))
    }
    
    func items() -> Observable<Results<WordDataModel>> {
        
        let result = withRealm("getting items") { realm -> Observable<Results<WordDataModel>> in
            let realm = try Realm()
            let items = realm.objects(WordDataModel.self)
            return Observable.collection(from: items)
        }
        return result ?? .empty()
    }

}
