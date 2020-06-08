## RIB Tree를 visualize하기

### 관련 코드

- https://github.com/srea/RIBsTreeViewerClient
- https://github.com/imairi/RIBsTreeMaker





### 립트리 스냅샷 로그 찍어보기 1

저는 RIB이 attach/detach될때마다 립트리가 로그에 찍히면 좋겠어서
[RIBsTreeViewerClient](https://github.com/srea/RIBsTreeViewerClient)를 참고하여서

[RIBTreeViewer](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/SimpleMemo/RIBs/RIBTreeViewer.swift) 를 만들었습니다.

<img width="585" alt="스크린샷 2020-05-28 오후 5 56 29" src="https://user-images.githubusercontent.com/9502063/83120869-903fc800-a10c-11ea-90d6-51f502dc0c43.png">


### 립트리 스냅샷 로그 찍어보기 2

router.log() 이런식으로 쓰고싶을때 쓸 수 있음. <br/>
딕셔너리보다 눈에 더 잘 들어옴.


```swift
extension Routing {
    
    func log() {
        print("🌳 RIBTree 🌳")
        print(RIBTree.treeLog(rootRouter: self))
    }
}

class RIBTree {
    
    class func treeLog(rootRouter: Routing, depth: Int = 0) -> String {
        
        var text = ""
        
        if depth == 0 {
            text += String(describing: rootRouter)
        } else {
            text += "\n" + String(repeating: "  ", count: depth) + "ㄴ" + String(describing: rootRouter)
        }
            
        if rootRouter is ViewableRouting {
            text += " (Viewable)"
        }
        
        if rootRouter.children.isEmpty {
            return text
        } else {
            text += rootRouter.children
                .map { treeLog(rootRouter: $0, depth: depth + 1) }
                .reduce("", +)
            return text
        }
    }
}
```
