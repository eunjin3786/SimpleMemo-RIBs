@testable import SimpleMemo
import RIBs
import RxSwift

class RootInteractableMock: RootInteractable {
    // Variables
    var router: RootRouting? { didSet { routerSetCallCount += 1 } }
    var routerSetCallCount = 0
    
    var listener: RootListener? { didSet { listenerSetCallCount += 1 } }
    var listenerSetCallCount = 0
    
    var isActive: Bool = false { didSet { isActiveSetCallCount += 1 } }
    var isActiveSetCallCount = 0
    
    var isActiveStreamSubjectSetCallCount = 0
    var isActiveStreamSubject: PublishSubject<Bool> = PublishSubject<Bool>() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
    var isActiveStream: Observable<Bool> { return isActiveStreamSubject }
    
    // Function Handlers
    var activateHandler: (() -> ())?
    var activateCallCount: Int = 0
    
    var deactivateHandler: (() -> ())?
    var deactivateCallCount: Int = 0
    
    var loginHandler: (() -> ())?
    var loginCallCount: Int = 0
    
    var logoutHandler: (() -> ())?
    var logoutCallCount: Int = 0

    init() {
        
    }
    
    func activate() {
        activateCallCount += 1
        if let activateHandler = activateHandler {
            return activateHandler()
        }
    }
    
    func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler = deactivateHandler {
            return deactivateHandler()
        }
    }
    
    func login() {
        loginCallCount += 1
        if let loginHandler = loginHandler {
            return loginHandler()
        }
    }
    
    func logOut() {
        logoutCallCount += 1
        if let logoutHandler = logoutHandler {
            return logoutHandler()
        }
    }
}

class RootViewControllableMock: RootViewControllable {
    // Variables
    var uiviewController: UIViewController = UIViewController() { didSet { uiviewControllerSetCallCount += 1 } }
    var uiviewControllerSetCallCount = 0
    
    // Function Handlers
    var presentHandler: ((_ viewController: ViewControllable) -> ())?
    var presentCallCount: Int = 0
    var dismissHandler: ((_ viewController: ViewControllable) -> ())?
    var dismissCallCount: Int = 0
    
    init() {
        
    }
    
    func present(viewController: ViewControllable) {
        presentCallCount += 1
        if let presentHandler = presentHandler {
            return presentHandler(viewController)
        }
    }

    func dismiss(viewController: ViewControllable) {
        dismissCallCount += 1
        if let dismissHandler = dismissHandler {
            return dismissHandler(viewController)
        }
    }
}

class LoggedOutBuildableMock: LoggedOutBuildable {
    // Function Handlers
    var buildHandler: ((_ listener: LoggedOutListener) -> LoggedOutRouting)?
    var buildCallCount: Int = 0
    
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }
}

class LoggedInBuildableMock: LoggedInBuildable {

    // Function Handlers
    var buildHandler: ((_ listener: LoggedInListener) -> LoggedInRouting)?
    var buildCallCount: Int = 0

    init() {
    }

    func build(withListener listener: LoggedInListener) -> LoggedInRouting {
        buildCallCount += 1
        if let buildHandler = buildHandler {
            return buildHandler(listener)
        }
        fatalError("Function build returns a value that can't be handled with a default value and its handler must be set")
    }
}

class LoggedInRoutingMock: LoggedInRouting {
    // Variables
    var interactable: Interactable { didSet { interactableSetCallCount += 1 } }
    var interactableSetCallCount = 0
    
    var children: [Routing] = [Routing]() { didSet { childrenSetCallCount += 1 } }
    var childrenSetCallCount = 0
    
    var lifecycleSubject: PublishSubject<RouterLifecycle> = PublishSubject<RouterLifecycle>() { didSet { lifecycleSubjectSetCallCount += 1 } }
    var lifecycleSubjectSetCallCount = 0
    var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject }
    
    // Function Handlers
    var cleanupViewsHandler: (() -> ())?
    var cleanupViewsCallCount: Int = 0
    
    var loadHandler: (() -> ())?
    var loadCallCount: Int = 0
    
    var attachChildHandler: ((_ child: Routing) -> ())?
    var attachChildCallCount: Int = 0
    
    var detachChildHandler: ((_ child: Routing) -> ())?
    var detachChildCallCount: Int = 0
    
    var detachMemosHandler: (() -> ())?
    var detachMemosCallCount: Int = 0
    
    var routeToMemosHandler: (() -> ())?
    var routeToMemosCallCount: Int = 0
    
    init(interactable: LoggedInInteractable) {
        self.interactable = interactable
    }

    func cleanupViews() {
        cleanupViewsCallCount += 1
        if let cleanupViewsHandler = cleanupViewsHandler {
            return cleanupViewsHandler()
        }
    }
    
    func load() {
        loadCallCount += 1
        if let loadHandler = loadHandler {
            return loadHandler()
        }
    }

    func attachChild(_ child: Routing) {
        attachChildCallCount += 1
        if let attachChildHandler = attachChildHandler {
            return attachChildHandler(child)
        }
    }

    func detachChild(_ child: Routing) {
        detachChildCallCount += 1
        if let detachChildHandler = detachChildHandler {
            return detachChildHandler(child)
        }
    }
    
    func detachMemosRIB() {
        detachMemosCallCount += 1
        if let detachMemosHandler = detachMemosHandler {
            return detachMemosHandler()
        }
    }
    
    func routeToMemosRIB() {
        routeToMemosCallCount += 1
        if let routeToMemosHandler = routeToMemosHandler {
            return routeToMemosHandler()
        }
    }
}


class LoggedInInteractableMock: LoggedInInteractable {
    // Variables
    var router: LoggedInRouting? { didSet { routerSetCallCount += 1 } }
    var routerSetCallCount = 0
    
    var listener: LoggedInListener? { didSet { listenerSetCallCount += 1 } }
    var listenerSetCallCount = 0
    
    var isActive: Bool = false { didSet { isActiveSetCallCount += 1 } }
    var isActiveSetCallCount = 0
    
    
    var isActiveStreamSubjectSetCallCount = 0
    var isActiveStreamSubject: PublishSubject<Bool> = PublishSubject<Bool>() { didSet { isActiveStreamSubjectSetCallCount += 1 } }
    var isActiveStream: Observable<Bool> { return isActiveStreamSubject }

    // Function Handlers
    var activateHandler: (() -> ())?
    var activateCallCount: Int = 0
    
    var deactivateHandler: (() -> ())?
    var deactivateCallCount: Int = 0
    
    var logoutHandler: (() -> ())?
    var logoutCallCount: Int = 0
    
    init() {
    }

    func activate() {
        activateCallCount += 1
        if let activateHandler = activateHandler {
            return activateHandler()
        }
    }

    func deactivate() {
        deactivateCallCount += 1
        if let deactivateHandler = deactivateHandler {
            return deactivateHandler()
        }
    }
    
    func logOut() {
        logoutCallCount += 1
        if let logoutHandler = logoutHandler {
            return logoutHandler()
        }
    }
}
