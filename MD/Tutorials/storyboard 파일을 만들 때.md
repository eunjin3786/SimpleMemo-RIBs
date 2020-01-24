# 1. 문제

이렇게 스토리보드 파일 만들기를 체크하고 RIB을 만들면....!! 
<img width="744" alt="스크린샷 2020-01-24 오후 5 51 25" src="https://user-images.githubusercontent.com/9502063/73056340-2602e680-3ed2-11ea-9b95-4ced60ccad50.png">

```swift
final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        return MainRouter(interactor: interactor, viewController: viewController)
    }
}
```

빌더가 이런 코드로 생깁니다.  
근데 xib로 만들때와는 다르게 `MainViewController()` 가 스토리보드 파일을 불러오지 못합니다.


# 2. 해결방법

```swift
final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController.create()
        
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        return MainRouter(interactor: interactor, viewController: viewController)
    }
}
```


create




# 3. 앱에서 이렇게 사용하면 좋아요 
## 3.1 프로토콜
## 3.2 enum

