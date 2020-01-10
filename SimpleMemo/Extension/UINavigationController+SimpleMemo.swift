import UIKit
import RIBs

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

// MARK: RIBs
extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController {
        return self
    }
    
    convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
