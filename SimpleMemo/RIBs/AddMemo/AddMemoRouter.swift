//
//  AddMemoRouter.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/11.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs

protocol AddMemoInteractable: Interactable {
    var router: AddMemoRouting? { get set }
    var listener: AddMemoListener? { get set }
}

protocol AddMemoViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class AddMemoRouter: ViewableRouter<AddMemoInteractable, AddMemoViewControllable>, AddMemoRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: AddMemoInteractable, viewController: AddMemoViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
