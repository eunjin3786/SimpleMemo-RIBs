//
//  MemosInteractor.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/10.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs
import RxSwift

protocol MemosRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MemosPresentable: Presentable {
    var listener: MemosPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MemosListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MemosInteractor: PresentableInteractor<MemosPresentable>, MemosInteractable, MemosPresentableListener {

    weak var router: MemosRouting?
    weak var listener: MemosListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MemosPresentable) {
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
}
