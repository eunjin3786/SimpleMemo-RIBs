# 1. RIBs의 철학

- Cross-Platform Mobile 아키텍쳐. 안드와 iOS 앱의 구조를 동일하게 가져갈 수 있음.
- 앱의 State를 모두 트리형태로 만들수있으면 좋을텐데! 라는 생각에서 시작된 립스.


# 2. RIB 이란 

RIB 트리에서 하나의 노드를 RIB이라고 한다. 

## 2.1 RIB의 구성요소 

<img width="1242" alt="스크린샷 2020-01-16 오후 10 04 50" src="https://user-images.githubusercontent.com/9502063/72527483-3a305d80-38ac-11ea-8f1f-71ab5a5655bf.png">


### Interactor

- 비즈니스 로직을 포함한다. ( Rx stream 구독, state 바꾸는 결정, 자식 RIB으로 어떤 RIB들이 attach 되어야하는지 결정)
- viewModel, reactor에 대응되는 개념이다. 

### Router

- Interactor에게 귀를 기울이고 있으며(A Router listens to the Interactor), interactor의 명령에 따라 자식 RIB들을 attach/detach 한다.

### Builder

- RIB 을 만들어준다. (instantiate RIB Classes)

### Component

- Builder를 보조해준다.
- RIB dependencies 를 관리하기 위해 사용된다.
- parent RIB의 Component는 child RIB의 Builder에 injected 된다. (child RIB이 parent RIB의 dependencies에 접근할 수 있게 하기 위해서)  
parent RIB 입장에서 본다면, Component를 통해 child RIB에게 어떤 dependencies를 노출할지 결정할 수 있게 되는 것이다. 

- Each injected Component decides what dependencies to expose to the children on its own.
- The Components provide access to the external dependencies that are needed to build  RIB as well as own the dependencies created by the RIB itself and control access to them from the other RIBs.


### View(Controller)

- UI 담당 (This includes instantiating and laying out UI components, handling user interaction, filling UI components with data, and animations)

### Presenter

- interactor과 View의 다리 역할 느낌
- presenter를 사용한다면, view는 interactor와 직접 소통하는 것이 아니라 presenter를 거쳐서 소통한다. 


# 3. RIB의 라이프사이클 
Active, InActive 두가지 상태중 하나이다. 


# 4. RIB들간의 의사소통

## 4.1 listener interface를 통해 소통하는 방법
부모 RIB은 자식 RIB의 listener interface를 구현하고 있어서, 자식 RIB이 부모 RIB에게 notify할 수 있다.

<img width="515" alt="스크린샷 2020-01-16 오후 10 11 55" src="https://user-images.githubusercontent.com/9502063/72527931-36510b00-38ad-11ea-86cf-7fb5e8c0e657.png">


## 4.2 Rx stream을 통해 소통하는 방법 
자식 RIB의 build method에 파라미터를 추가해서 부모 RIB의 스트림을 주입해준다. 같은 스트림을 구독하고 있으므로 아래의 사진과 같이 소통할 수 있다.  
<img width="517" alt="스크린샷 2020-01-16 오후 10 14 49" src="https://user-images.githubusercontent.com/9502063/72528102-9e075600-38ad-11ea-9a44-ef25ea88c221.png">



이 방법은 child RIB이 부모 RIB으로부터 dynamic data(계속 변하는)를 받아야할 때 주로 사용한다. 
