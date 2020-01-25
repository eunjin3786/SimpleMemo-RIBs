[우버의 테스트 코드](https://raw.githubusercontent.com/uber/ribs/assets/tutorial_assets/ios/tutorial2-composing-ribs/source/source3.swift)를 따라해보았습니다.

# 1. RootRouter 테스트

`RootRouter`의  `routeToLoggedIn` 메소드의 행동에 대해서 테스트 코드를 작성해봅시다.

이 메소드가 불리면 `RootRouter`는  `LoggedInBuildable` 프로토콜의 `build` 메소드를 invoke해야하고 이 메소드가 리턴해준 router를 attach 해야합니다. 





## 1.1 테스트 파일 만들기 

SimpleMemoTests 밑에 RIBs > Root 그룹을 만들고   

RIB Unit Test 템플릿을 이용하여 테스트 파일을 만들어줍니다.   

그럼 이렇게 `RootInteractorTests` 와 `RootRouterTests` 가 만들어졌습니다. 


<img width="391" alt="스크린샷 2020-01-17 오후 5 33 51" src="https://user-images.githubusercontent.com/9502063/72596547-88e30380-394f-11ea-9e14-c9b85573c6e6.png">





두 개의 파일은 이렇게 생겨있습니다.   

```swift
@testable import SimpleMemo
import XCTest
import RIBs

final class RootInteractorTests: XCTestCase {

    private var interactor: RootInteractor!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        // TODO: instantiate objects and mocks
    }

    // MARK: - Tests

    func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
        // This is an example of an interactor test case.
        // Test your interactor binds observables and sends messages to router or listener.
    }
}

```



```swift
@testable import SimpleMemo
import XCTest
import RIBs

final class RootRouterTests: XCTestCase {

    private var router: RootRouter!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()

        // TODO: instantiate objects and mocks
    }

    // MARK: - Tests

    func test_routeToExample_invokesToExampleResult() {
        // This is an example of a router test case.
        // Test your router functions invokes the corresponding builder, attachesChild, presents VC, etc.
    }
}

```



## 1.2 Mock 만들기 

우선 setup에서 RootRouter를 만들어줘야합니다.  

근데 RootRouter를 만드려면 다음과 같은 것들을 주입해줘야합니다.  



```swift
final class RootRouterTests: XCTestCase {

    private var router: RootRouter!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        // TODO: instantiate objects and mocks
        router = RootRouter(interactor: <#T##RootInteractable#>,
                            viewController: <#T##RootViewControllable#>,
                            loggedOutBuilder: <#T##LoggedOutBuildable#>,
                            loggedInBuilder: <#T##LoggedInBuildable#>)
    }
}
```



그래서 Mock을 만듭시다.  

우버의 가이드를 따라 만듭니다.  



```swift
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


```



드디어 setup할 수 있게 되었습니다..! 

```swift
final class RootRouterTests: XCTestCase {

    private var router: RootRouter!

    // TODO: declare other objects and mocks you need as private vars

    override func setUp() {
        super.setUp()
        // TODO: instantiate objects and mocks
        router = RootRouter(interactor: RootInteractableMock(),
                            viewController: RootViewControllableMock(),
                            loggedOutBuilder: LoggedOutBuildableMock(),
                            loggedInBuilder: LoggedInBuildableMock())
    }

    // MARK: - Tests

    func test_routeToExample_invokesToExampleResult() {
        // This is an example of a router test case.
        // Test your router functions invokes the corresponding builder, attachesChild, presents VC, etc.
    }
}
```



`loggedInBuilder` 와 `rootInteractor` 를 테스트함수에서 써줄 것이기 때문에 프로퍼티로 빼줍니다. 

```swift
final class RootRouterTests: XCTestCase {
    
    // TODO: declare other objects and mocks you need as private vars
    private var loggedInBuilder: LoggedInBuildableMock!
    private var rootInteractor: RootInteractableMock!
    private var rootRouter: RootRouter!

    override func setUp() {
        super.setUp()
        loggedInBuilder = LoggedInBuildableMock()
        rootInteractor = RootInteractableMock()
        rootRouter = RootRouter(interactor: rootInteractor,
                            viewController: RootViewControllableMock(),
                            loggedOutBuilder: LoggedOutBuildableMock(),
                            loggedInBuilder: loggedInBuilder)
    }
}
```



## 1.3 test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter 작성하기 

우리가 작성한 `LoggedInBuildableMock` 은   

이렇게 되어있습니다. 

build하면 LoggedInRouting을 리턴해주도록 buildHandler를 작업해줘야합니다. 

```swift

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

```



우선 build 함수가 불리면 listener가 잘 set되는지도 밑에서 테스트해볼 것이기때문에 

`assignedListener` 프로퍼티를 만들어줍니다. 

```swift
func test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter() {
    var assignedListener: LoggedInListener? = nil
    loggedInBuilder.buildHandler = { (_listener: LoggedInListener) -> LoggedInRouting in
        assignedListener = listener
    }
}
```



그리고 `LoggedInRoutingMock` 을 만들어주세요 이니셜라이저는 Interactor만 받게 해주면 됩니다 : ) 



```swift
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
```



그리고  `LoggedInRoutingMock`  을 instantiate할때 필요하니까 `LoggedInInteractableMock` 도 만들어줍니다. 

```swift
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

```



이제 `loggedInBuildHandler` 를 마무리해줍니다. build함수가 불리면 listener를  assignedListener에 set해주고 router를 리턴해주게 될 것입니다. 

```swift
  func test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter() {
      let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
      var assignedListener: LoggedInListener? = nil
      loggedInBuilder.buildHandler = { (_ listener: LoggedInListener) -> LoggedInRouting in
          assignedListener = listener
          return loggedInRouter
      }
  }
```



이렇게까지하고 `assignedListener` 가 nil인지, build랑 router callCount가 0인지 테스트 합니다. 

```swift
  func test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter() {
      let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
      var assignedListener: LoggedInListener? = nil
      loggedInBuilder.buildHandler = { (_ listener: LoggedInListener) -> LoggedInRouting in
          assignedListener = listener
          return loggedInRouter
      }

       XCTAssertNil(assignedListener)
       XCTAssertEqual(loggedInBuilder.buildCallCount, 0)
       XCTAssertEqual(loggedInRouter.loadCallCount, 0)
  }
```



그리고 드디어 `routeToLoggedInRIB()` 를 불러봅니다.  아래에 우리가 확인하고 싶은 assert문도 추가합니다.

테스트를 돌려보면 성공입니다..!! 



```swift
  func test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter() {
      let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
      var assignedListener: LoggedInListener? = nil
      loggedInBuilder.buildHandler = { (_ listener: LoggedInListener) -> LoggedInRouting in
          assignedListener = listener
          return loggedInRouter
      }

      XCTAssertNil(assignedListener)
      XCTAssertEqual(loggedInBuilder.buildCallCount, 0)
      XCTAssertEqual(loggedInRouter.loadCallCount, 0)

      rootRouter.routeToLoggedInRIB()
    
      XCTAssertTrue(assignedListener === rootInteractor)
      XCTAssertEqual(loggedInBuilder.buildCallCount, 1)
      XCTAssertEqual(loggedInRouter.loadCallCount, 1)
  }
```



테스트가 어떻게 돌아가고 성공했는지 살펴보겠습니다 <br/><br/>



우리는 "test_routeToLoggedIn_verifyInvokeBuilderAttachReturnedRouter" 을 테스트하고 있으니까 loggedInBuilder 쪽 코드만 유의해서 봐줍니다. 

 이 함수는 loggedInBuilder.build를 부르게 됩니다. 

```swift
    func routeToLoggedInRIB() {
        if let loggedOutRouting = loggedOutRouting {
            detachChild(loggedOutRouting)
            if let navigationController = loggedOutRouting.viewControllable.uiviewController.navigationController {
                viewController.dismiss(viewController: navigationController)
            } else {
                viewController.dismiss(viewController: loggedOutRouting.viewControllable)
            }
            self.loggedOutRouting = nil
        }
        
        let loggedInRouting = loggedInBuilder.build(withListener: interactor)
        self.loggedInRouting = loggedInRouting
        attachChild(loggedInRouting)
    }
```



그러면 우리가 `loggedInBuilder`로 주입해준 `LoggedInBuildableMock` 의 build가 불리면서   

주입받은 listener를 가지고 buildHandler를 불러주겠죠?+?   

그러면 아까 buildHandler로 넣어준 동작이 일어나게 될 것입니다. 



```swift
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
```



그리고 `routeToLoggedInRIB()` 으로 돌아갑시다!!  

build다음 라인인 `attachChild` 를 하면 load가 불립니다. 



```swift
    public final func attachChild(_ child: Routing) {
        assert(!(children.contains { $0 === child }), "Attempt to attach child: \(child), which is already attached to \(self).")

        children.append(child)

        // Activate child first before loading. Router usually attaches immutable children in didLoad.
        // We need to make sure the RIB is activated before letting it attach immutable children.
        child.interactable.activate()
        child.load()
    }
```



그러면 `LoggedInRouting` 으로 주입해준 `LoggedInRoutingMock` 의 load가 불리면서 loadCallCount가 증가하겠죠?+?

```swift
class LoggedInRoutingMock: LoggedInRouting {
    ... 
    var loadHandler: (() -> ())?
    var loadCallCount: Int = 0
    
    func load() {
        loadCallCount += 1
        if let loadHandler = loadHandler {
            return loadHandler()
        }
    }
    ... 
}
```




