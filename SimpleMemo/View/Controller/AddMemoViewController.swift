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

protocol AddMemoDelegate {
    func addMemoDidSave(memo: Memo)
}

class AddMemoViewController: UIViewController {
    
    @IBOutlet weak var addMemoTextField: UITextField!
    @IBOutlet weak var saveMemoButton: UIButton!
    
    var delegate: AddMemoDelegate?
    private var viewModel = AddMemoViewModel()
    private let bag = DisposeBag() 

    override func viewDidLoad() {
        super.viewDidLoad()
        saveMemoButton.rx.tap.withLatestFrom(addMemoTextField.rx.text.orEmpty)
            .filter { $0 != "" }
            .map { return Memo(title: $0) }
            //.bind(to: viewModel.action.saveMemo)
            .subscribe(onNext: { memo in
                self.viewModel.action.saveMemo.onNext(memo)
                self.delegate?.addMemoDidSave(memo: memo)
            })
            .disposed(by: bag)
    }
}
