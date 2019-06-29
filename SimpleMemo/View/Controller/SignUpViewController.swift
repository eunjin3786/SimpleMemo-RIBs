//
//  SignUpViewController.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 31/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import UIKit
import RxSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    private var viewModel: SignupViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignupViewModel()
        
        Observable.combineLatest(emailTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty) { email, password -> Bool in
            return LoginTextInputManager.isValidEmail(email) && LoginTextInputManager.isValidPassword(password)
            }
            .subscribe(onNext: { [weak self] isValid in
                isValid ? (self?.signupButton.isEnabled = true) : (self?.signupButton.isEnabled = false)
            }).disposed(by: bag)
        
        
        signupButton.rx.tap.map { [weak self] _ in
            return (self?.emailTextField.text ?? "", self?.passwordTextField.text ?? "")
            }
            .bind(to: viewModel.action.signup)
            .disposed(by: bag)
    }
}
