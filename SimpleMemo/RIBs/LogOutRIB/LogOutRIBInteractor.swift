//
//  LogOutRIBInteractor.swift
//  SimpleMemo
//
//  Created by Jinny on 2020/01/08.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs
import RxSwift

protocol LogOutRIBRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LogOutRIBPresentable: Presentable {
    var listener: LogOutRIBPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LogOutRIBListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LogOutRIBInteractor: PresentableInteractor<LogOutRIBPresentable>, LogOutRIBInteractable, LogOutRIBPresentableListener {

    weak var router: LogOutRIBRouting?
    weak var listener: LogOutRIBListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LogOutRIBPresentable) {
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
