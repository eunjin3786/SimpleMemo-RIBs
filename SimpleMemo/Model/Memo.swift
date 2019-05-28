//
//  Memo.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 26/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

struct Memo {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    init?(dic: [String: Any]) {
        guard let title = dic["title"] as? String else {
            return nil
        }
        
        self.title = title
    }
}

extension Memo {
    func toDictionary() -> [String: Any] {
        return ["title": title]
    }
}
