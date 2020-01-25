#  1. 기본 Modal Style로 present 했다면  

<img width="360" alt="스크린샷 2020-01-25 오후 9 44 10" src="https://user-images.githubusercontent.com/9502063/73121299-0c3dce00-3fbc-11ea-9b4c-40c1d1f096eb.png">

기본 Modal Style로 present 했다면 이렇게 모달 식으로 present 됩니다.  
사용자가 X버튼을 눌렀을때 dismiss되고, 아래로 스크롤해서도 dismiss 됩니다...!! 



X버튼을 눌렀을 때는 버튼에 액션을 연결해서 이렇게 listener에게 dismiss 액션을 알려줬습니다.  (그로 인해 알림을 받은 부모 RIB이 자식 RIB을 detach하고 자식 RIB의 화면을 dismiss 할 수 있었음.)

```swift
    @IBAction func dismissDidTap(_ sender: Any) {
        listener?.dismissDidTap()
    }
```



아래로 스크롤할때도 listener에게 dismiss 액션을 알려줘야합니다...!! 그렇지 않으면 화면은 dismiss되었지만, 자식 RIB이 detach가 안됩니다..!! (자식 RIB interactor의 resign함수랑 deinit이 불리지 않는 것을 보고 확인 할 수 있습니다) 



그래서 `viewDidDisappear` 또는 `viewWillDisappear` 에 `isBeingDismissed` 프로퍼티를 활용하여 리스너에게 알려주는 코드를 추가해주세요 꼭! 

```swift
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isBeingDismissed {
            listener?.dismissDidTap()
        }
    }
```



## 2. Navigation으로 Push 했다면 

NavigationController로 자식 RIB의 화면을 푸쉬했다고 가정해봅시다. 

자동으로 생기는 Back Button과 Swipe Back액션으로 화면을 pop할 수 있습니다.  

이때도 화면은 pop되었지만 자식 RIB이 detach가 안됩니다.  (자식 RIB interactor의 resign함수랑 deinit이 불리지 않는 것을 보고 확인 할 수 있습니다) 



그래서 `viewDidDisappear` 또는 `viewWillDisappear` 에 `isMovingFromParent` 프로퍼티를 활용하여 리스너에게 알려주는 코드를 추가해주세요 꼭! 



```swift
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.backDidTap()
        }
    }
```

