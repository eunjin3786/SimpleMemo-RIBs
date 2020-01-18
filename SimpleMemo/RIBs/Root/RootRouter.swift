
import RIBs
import RxSwift

protocol RootInteractable: Interactable, LoggedOutListener, LoggedInListener  {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouting: ViewableRouting?
    
    private let loggedInBuilder: LoggedInBuildable
    private var loggedInRouting: LoggedInRouting?
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable,
         loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        route()
    }
    
    func route() {
        if FirebaseManager.isLogin {
            routeToLoggedInRIB(email: FirebaseManager.userEmail)
        } else {
            routeToLoggedOutRIB()
        }
    }
    
    func routeToLoggedOutRIB() {
        if let loggedInRouting = loggedInRouting {
            detachChild(loggedInRouting)
            self.loggedInRouting = nil
        }
        
        let loggedOutRouting = loggedOutBuilder.build(withListener: interactor)
        self.loggedOutRouting = loggedOutRouting
        attachChild(loggedOutRouting)
        let navigationController = UINavigationController(root: loggedOutRouting.viewControllable)
        viewController.present(viewController: navigationController)
    }
    
    func routeToLoggedInRIB(email: String) {
        if let loggedOutRouting = loggedOutRouting {
            detachChild(loggedOutRouting)
            if let navigationController = loggedOutRouting.viewControllable.uiviewController.navigationController {
                viewController.dismiss(viewController: navigationController)
            } else {
                viewController.dismiss(viewController: loggedOutRouting.viewControllable)
            }
            self.loggedOutRouting = nil
        }
        
        let loggedInRouting = loggedInBuilder.build(withListener: interactor,
                                                    email: email)
        self.loggedInRouting = loggedInRouting
        attachChild(loggedInRouting)
    }
}
