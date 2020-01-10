//
//  MemosViewController.swift
//  SimpleMemo
//
//  Created by eunjin on 2020/01/10.
//  Copyright © 2020 eunjin. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol MemosPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class MemosViewController: UIViewController, MemosPresentable, MemosViewControllable {

    weak var listener: MemosPresentableListener?
}
