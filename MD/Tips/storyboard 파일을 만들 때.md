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

일단 `MainViewController.create()` 로 뷰컨트롤러를 불러오는 부분을 바꿔주세요 

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


## 2.1 instantiateInitialViewController 를 이용해 create 함수 만들기 

```swift
final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    
    static func create() -> Self {
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateInitialViewController() as! Self
    }
}
```

## 2.2 instantiateInitialViewController 를 이용해 create 함수 만들기 

우선 MainViewController.storyboard에 있는 MainViewController에 가서 Storyboard ID 설정을 해줍니다. 

<img width="262" alt="스크린샷 2020-01-24 오후 7 06 20" src="https://user-images.githubusercontent.com/9502063/73061055-9d3d7800-3edc-11ea-8b5f-d9d270e619d0.png">


```swift
final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    
    static func create() -> Self {
        return UIStoryboard(name: "\(self)", bundle: nil).instantiateViewController(identifier: "\(self)")
    }
}
```



# 3. 앱에서 이렇게 사용하면 좋아요 
## 3.1 프로토콜

이런 프로토콜과 extension을 만듭니다. 

```swift
protocol CreatableFromStoryboardForRIBs {
    
}

extension CreatableFromStoryboardForRIBs where Self: UIViewController {
    static func create() -> Self {
        guard let vc = UIStoryboard(name: "\(self)", bundle: nil).instantiateInitialViewController() as? Self else {
            fatalError("Storyboard \(self)를 찾을 수 없음.")
        }
        return vc
    }
}

```

그리고 creat함수를 일일이 만들지 말고, CreatableFromStoryboardForRIBs 프로토콜을 따르게 해줍니다-! 

```swift
final class MainViewController: UIViewController, MainPresentable, MainViewControllable, CreatableFromStoryboardForRIBs {

    weak var listener: MainPresentableListener?
    
}
```

## 3.2 enum

다른 분의 깃헙에서 본 건데, 이런식으로 스토리보드를 만들때마다 enum에 추가해서 쓰시기도 하더라구요..!! 

```swift
enum Storyboard: String {
    case MainViewController 
    case MemosViewController
    case SettingViewController
    
    
    func instantiate<VC: UIViewController>(_: VC.Type) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() as? VC else {
            fatalError("Storyboard \(self.rawValue) wasn`t found.")
        }
        return vc
    }
}
```


```swift
final class MemosViewController: UIViewController, MemosPresentable {

    weak var listener: MemosPresentableListener?

    static func create() -> Self {
        return Storyboard.MemosViewController.instantiate(self)
    }
}
```

저는 뷰컨트롤러마다 create함수를 만들기 싫어서 3.1의 방법으로 쓰겠습니당 --!! 
