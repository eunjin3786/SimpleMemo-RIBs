//
//  Navigator.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 31/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import UIKit

class Navigator {
    class func presentAlert(with message: String, action: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: action)
        alertController.addAction(okAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    class func present(to viewController: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) {
        UIApplication.topViewController()?.present(viewController, animated: animated, completion: completion)
    }
    
    class func push() {
        
    }
    
    class func changeRootViewController(to viewController: UIViewController) {
        let appDelegate = UIApplication.shared.delegate
        if let window = appDelegate?.window {
            window?.rootViewController = viewController
        }
    }
}
