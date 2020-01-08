
import RIBs
import JinnyAppKit

protocol LogOutRIBDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LogOutRIBComponent: Component<LogOutRIBDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LogOutRIBBuildable: Buildable {
    func build(withListener listener: LogOutRIBListener) -> LogOutRIBRouting
}

final class LogOutRIBBuilder: Builder<LogOutRIBDependency>, LogOutRIBBuildable {

    override init(dependency: LogOutRIBDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LogOutRIBListener) -> LogOutRIBRouting {
        _ = LogOutRIBComponent(dependency: dependency)
        //let viewController = LogOutRIBViewController.instanceFromNib()
        let viewController = LogOutRIBViewController() 
        let interactor = LogOutRIBInteractor(presenter: viewController)
        interactor.listener = listener
        return LogOutRIBRouter(interactor: interactor, viewController: viewController)
    }
}
