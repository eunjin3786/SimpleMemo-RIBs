//
//  AddMemoViewController.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 26/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class _AddMemoViewController: UIViewController {
    
    @IBOutlet weak var addMemoTextField: UITextField!
    @IBOutlet weak var saveMemoButton: UIButton!
    
    private var viewModel = AddMemoViewModel()
    private let bag = DisposeBag() 

    override func viewDidLoad() {
        super.viewDidLoad()
    saveMemoButton.rx.tap.withLatestFrom(addMemoTextField.rx.text.orEmpty)
        .filter { $0 != "" }
        .map { return Memo(title: $0) }
        .bind(to: viewModel.action.saveMemo)
        .disposed(by: bag)
    }
}
