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
    
    @discardableResult
    func createItem(item: WordDataModel) -> Observable<WordDataModel> {
        
        let result = withRealm("creating") { realm -> Observable<WordDataModel> in
            
            try realm.write {
                
                realm.add(item)
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

    
    @discardableResult
    func update(item: WordDataModel, collection: Bool) -> Observable<WordDataModel> {
        
        let result = withRealm("updating collection") { realm -> Observable<WordDataModel> in
            try realm.write {
                item.collection = collection
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