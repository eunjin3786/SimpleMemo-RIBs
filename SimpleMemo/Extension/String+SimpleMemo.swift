//
//  String+SimpleMemo.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 2019/06/10.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

extension String {
    func removeSpecialCharacters() -> String {
        return self.components(separatedBy: CharacterSet.letters.inverted).joined()
    }
}
