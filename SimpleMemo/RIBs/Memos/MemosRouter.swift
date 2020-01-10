//
//  MemosRouter.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/10.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs

protocol MemosInteractable: Interactable {
    var router: MemosRouting? { get set }
    var listener: MemosListener? { get set }
}

protocol MemosViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MemosRouter: ViewableRouter<MemosInteractable, MemosViewControllable>, MemosRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MemosInteractable, viewController: MemosViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
