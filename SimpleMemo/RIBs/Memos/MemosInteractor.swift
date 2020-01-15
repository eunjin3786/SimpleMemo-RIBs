import RIBs
import RxSwift
import RxCocoa

protocol MemosRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func moveToAddMemo()
    func backFromAddMemo()
}

protocol MemosPresentable: Presentable {
    var listener: MemosPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol MemosListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func logOut()
}

final class MemosInteractor: PresentableInteractor<MemosPresentable>, MemosInteractable {
    
    weak var router: MemosRouting?
    weak var listener: MemosListener?
    
    var memos: BehaviorRelay<[Memo]> = BehaviorRelay.init(value: [])
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MemosPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        FirebaseManager.fetchAll()
            .bind(to: memos)
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func navigationBack() {
        router?.backFromAddMemo()
    }
}

// MARK: MemosPresentableListener
extension MemosInteractor: MemosPresentableListener {
    
    func deleteMemo(_ memo: Memo) {
        FirebaseManager.delete(key: memo.ID)
    }
    
    func changeMemo(_ memo: Memo) {
        FirebaseManager.change(key: memo.ID, to: memo)
    }
    
    func moveToAddMemoButtonDidTap() {
        router?.moveToAddMemo()
    }
    
    func logOutButtonDidTap() {
        listener?.logOut()
    }
}
