
import RIBs
import RxSwift

protocol RootInteractable: Interactable, LogOutRIBListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let logOutRIBBuilder: LogOutRIBBuildable
    
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         logOutRIBBuilder: LogOutRIBBuildable) {
        self.logOutRIBBuilder = logOutRIBBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToLogOutRIB() {
        let logOutRIBRouting = logOutRIBBuilder.build(withListener: interactor)
        attachChild(logOutRIBRouting)
        viewController.present(viewController: logOutRIBRouting.viewControllable)
    }
    
    override func didLoad() {
        super.didLoad()
        routeToLogOutRIB()
    }
}
