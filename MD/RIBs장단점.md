# 1. RIBs의 강점

## 1.1 View-driven 아키텍쳐가 아니다
대부분의 아키텍쳐는 뷰에 기반하여서 상태가 바뀌는 view driven 형태이다.  
ex) viewController가 viewModel, reactor를 가지고 있다.  

립스의 가장 큰 차이점은 뷰가 아니라 비즈니스 로직, 즉 RIB 트리에 의해 상태가 바뀐다는 것이다.  


## 1.2 철저한 Scope 분리 

오브젝트들의 scope가 제한된다는 점도 큰 강점이다. 
립스에서는 해당 노드안에 특정 데이터가 존재한다는게 보장되니까 옵셔널과 if문이 빠질 수 있다. 

예를 들어   

이런 RIB트리가 있다고 하자.  

<img width="823" alt="스크린샷 2020-01-16 오후 10 33 04" src="https://user-images.githubusercontent.com/9502063/72529225-2ab31380-38b0-11ea-8d7d-92619bee2a16.png">


현재 로그인 RIB이라면 authoToken이 확실히 있다는 것이 보장된다. 
그래서 아래와 같은 코드를 

<img width="701" alt="스크린샷 2020-01-16 오후 10 33 27" src="https://user-images.githubusercontent.com/9502063/72529255-38689900-38b0-11ea-845c-a046a088daaf.png">

이렇게 바꿀 수 있는 것이다. 

<img width="706" alt="스크린샷 2020-01-16 오후 10 33 47" src="https://user-images.githubusercontent.com/9502063/72529272-44545b00-38b0-11ea-952c-a7d98340c8d9.png">

그리고 Ride라는 RIB이 추가되어서 현재 RideRIB이라면 

<img width="694" alt="스크린샷 2020-01-16 오후 10 36 50" src="https://user-images.githubusercontent.com/9502063/72529447-b2008700-38b0-11ea-8e84-a3e1e3a473f7.png">


ride 상태라는 것이 보장되기 때문에 아래와 같은 if문이 빠지고 

<img width="829" alt="스크린샷 2020-01-16 오후 10 36 29" src="https://user-images.githubusercontent.com/9502063/72529416-a4e39800-38b0-11ea-9bcb-28198b0377d5.png">

이런 코드가 나올 수 있게 되는 것이다. 

<img width="688" alt="스크린샷 2020-01-16 오후 10 37 02" src="https://user-images.githubusercontent.com/9502063/72529454-b88efe80-38b0-11ea-92a9-c19f9a1b5621.png">


(출처: [RxRIBs: Multiplatform architecture with Rx](https://speakerdeck.com/vcnc/rxribs-multiplatform-architecture-with-rx) - 김남현님)


또한 부모 RIB에서 데이터를 주입해주니까 다른데서 변경이 불가하다는 점도 강점이다.


## 1.3 협업 Good 

1.2 내용처럼 스코프가 갇히는 것은 협업을 빠르게 가능하게 해준다.  
각 RIB은 dependency 주입만 제대로 되면 독립적으로 개발 가능하기 때문이다.  
레고블럭을 쌓듯이 각 RIB을 개발하고 합칠 수있다.  

개발 전 리뷰도 편할 것이다. 
이런 식으로 RIB 트리를 그려서 공유한 후, 각자 개발을 진행할 수 있을 것이다. 

<img width="963" alt="스크린샷 2020-01-16 오후 10 27 25" src="https://user-images.githubusercontent.com/9502063/72528862-626d8b80-38af-11ea-9de0-8fe30c81ffa6.png">


## 1.4 템플릿 제공(테스트 코드에도)

### iOS
[iOS code generation templates for Xcode](https://github.com/uber/RIBs/tree/master/ios/tooling)
install-xcode-template.sh 을 run하면 Xcode에서 RIB 템플릿이 생기는데 진짜 편하다.  

<img width="974" alt="스크린샷 2020-01-16 오후 10 31 02" src="https://user-images.githubusercontent.com/9502063/72529089-e1fb5a80-38af-11ea-9d8d-0b74202007ff.png">

### Android 
[Android code generation IDE plugin](https://github.com/uber/RIBs/tree/master/android/tooling/rib-intellij-plugin)  

<img width="744" alt="스크린샷 2020-01-16 오후 10 30 14" src="https://user-images.githubusercontent.com/9502063/72529039-c6904f80-38af-11ea-942f-89097357ca68.png">


