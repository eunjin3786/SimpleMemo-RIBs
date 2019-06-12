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
    
    class var user: String {
        return Auth.auth().currentUser?.email?.removeSpecialCharacters() ?? ""
    }
    
    class func add(memo: Memo) {
        let rootRef = Database.database().reference()
        let memosRef = rootRef.child(user).child("memos")
        
        let memoRef = memosRef.childByAutoId()
        memoRef.setValue(memo.toDictionary())
    }
    
    class func fetchAll() -> Observable<[Memo]> {
        return Observable<[Memo]>.create { observer in
            let rootRef = Database.database().reference()
            rootRef.child(user).child("memos").observe(.value) { snapshot in
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
        let memoRef = rootRef.child(user).child("memos").child(key)
        memoRef.removeValue()
    }
    
    class func change(key: String, to memo: Memo) {
        let rootRef = Database.database().reference()
        let memoRef = rootRef.child(user).child("memos").child(key)
        memoRef.setValue(memo.toDictionary())
    }
}

extension FirebaseManager {

    class func signup(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let result = result {
                 completion(.success(result))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    class func login(email: String, password: String, completion: @escaping (Result<AuthDataResult,Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let result = result {
                completion(.success(result))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
