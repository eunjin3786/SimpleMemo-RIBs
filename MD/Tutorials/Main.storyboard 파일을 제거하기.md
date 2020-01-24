
RIBs를 쓰면 Main.storyboard 파일을 안쓰니까 지우고 싶습니다. 아래와 같이 해주면 됩니다 :-) 

# 1. AppDelegate를 사용할 때 

1. Main.storyboard 파일을 지워줍니다. 
2. Deployment Info > Main Interface 에 Main이라고 들어가있는 것을 아래와 같이 지워주세요.

<img width="663" alt="스크린샷 2020-01-24 오후 4 45 37" src="https://user-images.githubusercontent.com/9502063/73052658-f7344280-3ec8-11ea-9718-39ca8cade62e.png">

3. AppDelegate 

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)

        return true
    }
    ...
}
```



# 2. SceneDelegate를 사용할 때 

1. Main.Storyboard 파일을 지워줍니다.  
2. Deployment Info > Main Interface 에 Main이라고 들어가있는 것을 아래와 같이 지워주세요. 


<img width="663" alt="스크린샷 2020-01-24 오후 4 45 37" src="https://user-images.githubusercontent.com/9502063/73052658-f7344280-3ec8-11ea-9718-39ca8cade62e.png">

3. Info.plist 의 파란줄 라인을 지워주세요. 

<img width="667" alt="스크린샷 2020-01-24 오후 4 43 28" src="https://user-images.githubusercontent.com/9502063/73052822-6a3db900-3ec9-11ea-9ea3-8ec0b7eb5d9f.png">

4. SceneDelgate

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launchFromWindow(window)
    }
    ...
}
```


# 추가) AppDelegate를 사용할 때 
1. LaunchScreen.storyboard 파일을 지워줍니다.
2. App Icons and Launch Images > Launch Screen에 LaunchScreen이라고 되어있는 것을 아래와 같이 지워주세요.

<img width="767" alt="스크린샷 2020-01-24 오후 4 57 54" src="https://user-images.githubusercontent.com/9502063/73053485-34013900-3ecb-11ea-8965-dff1ad149552.png">
