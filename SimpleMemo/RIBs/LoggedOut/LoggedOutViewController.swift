
import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func loginDidTap(email: String, password: String)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.text = "simple@memo.com"
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.text = "12345678"
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    
    weak var listener: LoggedOutPresentableListener?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) { email, password -> Bool in
            return LoginTextInputManager.isValidEmail(email) && LoginTextInputManager.isValidPassword(password)
            }
            .subscribe(onNext: { [weak self] isValid in
                isValid ? (self?.loginButton.isEnabled = true) : (self?.loginButton.isEnabled = false)
            }).disposed(by: bag)
        
        loginButton.rx.tap.map { [weak self] _ in
            return (self?.emailTextField.text ?? "", self?.passwordTextField.text ?? "")
        }.subscribe(onNext: { [weak self] email, password in
            self?.listener?.loginDidTap(email: email, password: password)
        }).disposed(by: bag)
    }
}
