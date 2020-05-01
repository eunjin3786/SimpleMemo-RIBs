
import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func loginDidTap(email: String, password: String)
    func moveToSignUpDidTap()
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
    @IBOutlet weak var signupButton: UIButton!
    
    weak var listener: LoggedOutPresentableListener?
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        bindUI()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MintColor") ?? .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.title = "Simple Memo"
    }
    
    private func bindUI() {
        Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) { email, password -> Bool in
            return LoginTextInputManager.isValidEmail(email) && LoginTextInputManager.isValidPassword(password)
            }
            .subscribe(onNext: { [weak self] isValid in
                self?.loginButton.isEnabled = isValid
            }).disposed(by: bag)
        
        loginButton.rx.tap.map { [weak self] _ in
            return (self?.emailTextField.text ?? "", self?.passwordTextField.text ?? "")
        }.subscribe(onNext: { [weak self] email, password in
            self?.listener?.loginDidTap(email: email, password: password)
        }).disposed(by: bag)
        
        signupButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.listener?.moveToSignUpDidTap()
        }).disposed(by: bag)
    }
    
    func push(viewController: ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
}
