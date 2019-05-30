//
//  Memo.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 26/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

struct Memo {
    let ID: String
    var title: String

    init(title: String) {
        self.ID = ""
        self.title = title
    }
    
    init?(dic: [String: Any], ID: String) {
        guard let title = dic["title"] as? String else {
            return nil
        }
        
        self.ID = ID
        self.title = title
    }
}

extension Memo {
    func toDictionary() -> [String: Any] {
        return ["title": title]
    }
}
