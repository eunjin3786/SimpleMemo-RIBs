@testable import SimpleMemo
import XCTest

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

    // MARK: - Tests
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
}
