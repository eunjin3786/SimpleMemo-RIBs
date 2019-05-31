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
            print(email)
            print(password)
        }).disposed(by: bag)
    }
}
