import UIKit

extension UINavigationController {
    @IBInspectable var navigationLargeTitleBarColor: UIColor {
        set {
            self.view.backgroundColor = newValue
        }
        get {
            return self.view.backgroundColor ?? UIColor.black
        }
    }
}
