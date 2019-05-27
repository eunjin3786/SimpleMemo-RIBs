//
//  AddMemoViewModel.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 26/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import Foundation
import RxSwift

struct AddMemoViewModel {
    
    struct State {
        
    }
    
    struct Action {
        let saveMemo = PublishSubject<Memo>()
    }
    
    let state = State()
    let action = Action()
    private let bag = DisposeBag()
    
    init() {
        action.saveMemo.subscribe(onNext: { memo in
            print("add \(memo)")
        }).disposed(by: bag)
    }
}
