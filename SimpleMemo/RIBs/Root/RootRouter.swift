
import RIBs
import RxSwift

protocol RootInteractable: Interactable, LoggedOutListener  {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedOutBuilder: LoggedOutBuildable
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedOutBuilder: LoggedOutBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToLoggedOutRIB() {
        let loggedOutRouting = loggedOutBuilder.build(withListener: interactor)
        attachChild(loggedOutRouting)
        viewController.present(viewController: loggedOutRouting.viewControllable)
    }
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOutRIB()
    }
}
