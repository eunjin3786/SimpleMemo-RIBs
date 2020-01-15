import Foundation
import UIKit

class Navigator {
    class func presentAlert(with message: String, action: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: action)
        alertController.addAction(okAction)
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}
