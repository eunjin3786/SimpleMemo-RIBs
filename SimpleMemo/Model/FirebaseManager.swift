//
//  FirebaseManager.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 28/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class FirebaseManager {
    class func add(memo: Memo) {
        let rootRef = Database.database().reference()
        let memosRef = rootRef.child("memos")
        
        let memoRef = memosRef.childByAutoId()
        memoRef.setValue(memo.toDictionary())
    }
    
    class func fetchAll() -> Observable<[Memo]> {
        return Observable<[Memo]>.create { observer in
            let rootRef = Database.database().reference()
            rootRef.child("memos").observe(.value) { snapshot in
                var memos: [Memo] = []
                let memosDic = snapshot.value as? [String: Any] ?? [:]
                for (key, _) in memosDic.sorted(by: {$0.key < $1.key}) {
                    if let memoDic = memosDic[key] as? [String: Any], let memo = Memo(dic: memoDic, ID: key) {
                        memos.append(memo)
                    }
                }
                observer.onNext(memos)
            }
            return Disposables.create()
        }
    }
    
    class func delete(key: String) {
        let rootRef = Database.database().reference()
        let memoRef = rootRef.child("memos").child(key)
        memoRef.removeValue()
    }
    
    class func modify(key: String, to memo: Memo) {
        let rootRef = Database.database().reference()
        let memoRef = rootRef.child("memos").child(key)
        memoRef.setValue(memo.toDictionary())
    }
}
