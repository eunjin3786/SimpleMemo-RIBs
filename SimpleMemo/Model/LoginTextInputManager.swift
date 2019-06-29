//
//  LoginManager.swift
//  SimpleMemo
//
//  Created by kakao on 29/06/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation

class LoginTextInputManager {
    class func isValidEmail(_ email: String) -> Bool {
        return email.count >= 5
    }
    
    class func isValidPassword(_ password: String) -> Bool {
        return password.count >= 5
    }
}
