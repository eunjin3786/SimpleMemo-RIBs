//
//  MemosViewController.swift
//  SimpleMemo
//
//  Created by eunjin Jo on 26/05/2019.
//  Copyright © 2019 eunjin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MemoCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

class MemosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func logoutButtonPressed(_ sender: Any) {
        LoginManager.moveToLogin()
    }
    
    private var viewModel: MemosViewModel!
    private let bag = DisposeBag()
    
    private func bindTableView() {
        viewModel.state.memos.bind(to: tableView.rx.items(cellIdentifier: "MemoCell")) { (index, memo, cell) in
            if let cell = cell as? MemoCell {
                cell.titleLabel.text = memo.title
            }
        }.disposed(by: bag)
    }
    
    override func viewDidLoad() {
        viewModel = MemosViewModel()
        bindTableView()
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
}

extension MemosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let change = changeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [change])
    }
    
    private func changeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "수정") { [weak self] (action, view, completion) in
            guard let `self` = self else { return }
            let memo = self.viewModel.state.memos.value[indexPath.row]
            let alertController = UIAlertController(title: "메모 수정", message: nil, preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { textField in
                textField.text = memo.title
            })
            let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: { [weak self] _ in
                self?.tableView.setEditing(false, animated: true)
            })
            let saveAction = UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
                if let textField = alertController.textFields?.first, let text = textField.text {
                    if text == "" {
                        self?.viewModel.action.deleteMemo.onNext(memo)
                    } else {
                        var newMemo = memo
                        newMemo.title = text
                        self?.viewModel.action.changeMemo.onNext(newMemo)
                    }
                }
                self?.tableView.setEditing(false, animated: true)
            })
            alertController.addAction(cancleAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
        }
        action.backgroundColor = .orange
        return action
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "삭제") { [weak self] (action, view, completion) in
            guard let `self` = self else { return }
            let memo = self.viewModel.state.memos.value[indexPath.row]
            self.viewModel.action.deleteMemo.onNext(memo)
        }
        action.backgroundColor = .red
        return action
    }
}
