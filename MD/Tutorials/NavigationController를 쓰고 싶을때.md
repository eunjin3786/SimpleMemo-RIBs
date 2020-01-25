# NavigationController로 감싸고 싶을 때 

MainViewController를 네비게이션 컨트롤러로 감싸서 present하고 싶다면 이렇게 `UINavigationController`이 `ViewControllable`을 따르게 해주세요.  
그리고 `rootViewController`로 `ViewControllable`타입을 받는 이니셜라이저를 만들어주세요. 

```swift
extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController {
        return self
    }
    
    convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
```

그리고 route해주는 부분에서 네비게이션컨트롤러로 감싸서 present해주세요

```swift
final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {
     ... 
    func routeToMain() {
        let mainRouter = mainBuilder.build(withListener: interactor)
        attachChild(mainRouter)
        let navigationController = UINavigationController(root: mainRouter.viewControllable)
        viewController.present(viewController: navigationController)
    }
    ...
}
```
