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
    
    struct State {
        var memos: BehaviorRelay<[Memo]> = BehaviorRelay.init(value: [])
    }
    
    struct Action {
        let deleteMemo = PublishSubject<Memo>()
        let changeMemo = PublishSubject<Memo>()
    }
    
    let state = State()
    let action = Action()
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: MemosPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        action.deleteMemo.subscribe(onNext: { memo in
            FirebaseManager.delete(key: memo.ID)
        }).disposeOnDeactivate(interactor: self)
        
        action.changeMemo.subscribe(onNext: { memo in
            FirebaseManager.change(key: memo.ID, to: memo)
        }).disposeOnDeactivate(interactor: self)

        FirebaseManager.fetchAll()
            .bind(to: state.memos)
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
    var memos: BehaviorRelay<[Memo]> {
        return state.memos
    }
    
    var deleteMemo: PublishSubject<Memo> {
        return action.deleteMemo
    }
    
    var changeMemo: PublishSubject<Memo> {
        return action.changeMemo
    }
    
    func moveToAddMemoButtonDidTap() {
        router?.moveToAddMemo()
    }
    
    func logOutButtonDidTap() {
        listener?.logOut()
    }
}
