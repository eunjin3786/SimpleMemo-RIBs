//
//  FirebaseManager.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 28/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    class func add(memo: Memo) {
        let rootRef = Database.database().reference()
        let memosRef = rootRef.child("memos")
        
        let memoRef = memosRef.childByAutoId()
        memoRef.setValue(memo.toDictionary())
    }
}
