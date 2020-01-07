//
//  LoginManager.swift
//  SimpleMemo
//
//  Created by kakao on 29/06/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import UIKit

class LoginManager {
    class func moveToMemos() {
        let memosNavController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemosNavController")
        Navigator.changeRootViewController(to: memosNavController)
    }
    
    class func moveToLogin() {
        FirebaseManager.logout()
        let loginNavController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNavController")
        Navigator.changeRootViewController(to: loginNavController)
    }
}
