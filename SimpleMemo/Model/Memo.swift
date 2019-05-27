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
}

extension Memo {
    func toDictionary() -> [String: Any] {
        return ["title": title]
    }
}
