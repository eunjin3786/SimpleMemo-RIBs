import UIKit

enum Storyboard: String {
    case MemosViewController
    
    func instantiate<VC: UIViewController>(_: VC.Type) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() as? VC else {
            fatalError("Storyboard \(self.rawValue) wasn`t found.")
        }
        return vc
    }
}
