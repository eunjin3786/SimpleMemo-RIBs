

import RIBs
import RxSwift
import UIKit

protocol LogOutRIBPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class LogOutRIBViewController: UIViewController, LogOutRIBPresentable, LogOutRIBViewControllable {

    weak var listener: LogOutRIBPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
