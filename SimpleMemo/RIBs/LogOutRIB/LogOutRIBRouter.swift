//
//  LogOutRIBRouter.swift
//  SimpleMemo
//
//  Created by Jinny on 2020/01/08.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs

protocol LogOutRIBInteractable: Interactable {
    var router: LogOutRIBRouting? { get set }
    var listener: LogOutRIBListener? { get set }
}

protocol LogOutRIBViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LogOutRIBRouter: ViewableRouter<LogOutRIBInteractable, LogOutRIBViewControllable>, LogOutRIBRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: LogOutRIBInteractable, viewController: LogOutRIBViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
