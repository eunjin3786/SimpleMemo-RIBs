//
//  AddMemoViewController.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/11.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol AddMemoPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func navigationBackDidTap()
}

final class AddMemoViewController: UIViewController, AddMemoPresentable, AddMemoViewControllable {

    weak var listener: AddMemoPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.navigationBackDidTap()
        }
    }
}
