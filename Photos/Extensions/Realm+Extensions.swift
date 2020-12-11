//
//  Realm+Extensions.swift
//  Photos
//
//  Created by Ярослав Стрельников on 11.12.2020.
//

import Foundation
import RealmSwift

extension Results {
    public func safeObserve(_ block: @escaping (RealmCollectionChange<Results>) -> Void, completion: @escaping (NotificationToken) -> Void) {
        let realm = try! Realm()
        if (!realm.isInWriteTransaction) {
            let token = self.observe(block)
            completion(token)
        } else {
            DispatchQueue.main.async(after: 0.1) {
                self.safeObserve(block, completion: completion)
            }
        }
    }
}
extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if (isInWriteTransaction) {
            try block()
        } else {
            try write(block)
        }
    }
}
