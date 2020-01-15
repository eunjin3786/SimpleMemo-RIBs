import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func detachMemosRIB()
}

protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func logOut()
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func logOut() {
        FirebaseManager.logout()
        router?.detachMemosRIB()
        listener?.logOut()
    }
}
