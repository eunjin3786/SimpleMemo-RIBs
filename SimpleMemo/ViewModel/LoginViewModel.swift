//
//  LoginViewModel.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 31/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    struct State {
        
    }
    
    struct Action {
        let login = PublishSubject<(String, String)>()
    }
    
    let state = State()
    let action = Action()
    private let bag = DisposeBag()
    
    init() {
        action.login.subscribe(onNext: { email, password in
            FirebaseManager.login(email: email, password: password, completion: { result in
                switch result {
                case .success:
                    let navController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MemosNavController")
                    Navigator.present(to: navController)
                case .failure(let failure):
                    Navigator.presentAlert(with: failure.localizedDescription)
                }
            })
        }).disposed(by: bag)
    }
}
