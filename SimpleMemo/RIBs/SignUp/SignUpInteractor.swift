//
//  SignUpInteractor.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/15.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs
import RxSwift

protocol SignUpRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SignUpPresentable: Presentable {
    var listener: SignUpPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func navigationBack()
    func signupAndLoginDidSuccess()
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable, SignUpPresentableListener {

    weak var router: SignUpRouting?
    weak var listener: SignUpListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func navigationBackDidTap() {
        listener?.navigationBack()
    }
    
    func signupDidTap(email: String, password: String) {
        FirebaseManager.signup(email: email, password: password, completion: { [weak self] result in
            switch result {
            case .success:
                Navigator.presentAlert(with: "회원가입 완료", action: { _ in
                    self?.listener?.signupAndLoginDidSuccess()
                })
            case .failure(let error):
                Navigator.presentAlert(with: error.localizedDescription)
            }
        })
    }
}
