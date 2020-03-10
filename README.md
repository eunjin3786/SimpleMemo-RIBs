# SimpleMemo-RIBs

## 1. 프로젝트 소개

Firebase realtime database를 연습해보기 위해 [기존 MVVM로 구현했던 프로젝트](https://github.com/eunjin3786/SimpleMemo) 를
[RIBs](https://github.com/uber/RIBs)로 바꾸어본 프로젝트입니다. 



## 2. RIBs 간단 소개

| Number |                            Title                             |                             Memo                             |
| :----: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|   1    | [RIBs소개](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/RIBs소개.md) | - RIBs의 철학  <br />- RIB 트리, RIB 구성요소, RIB 라이프사이클<br />- RIB들간의 의사소통 |
|   2    | [RIBs의 장단점](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/RIBs장단점.md) |                                                              |
|   3    | [RIBs 참고자료](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/RIBs참고자료.md) |                                                              |





## 3. RIB 트리 

![무제 001](https://user-images.githubusercontent.com/9502063/72495313-b0f83700-3869-11ea-9f56-18d7e540fa36.jpeg)



## 4. 튜토리얼

SimpleMemo프로젝트를 RIBs로 바꾸면서 작성한 튜토리얼입니다.

### 기본

| Number |                            Title                             | Memo |
| :----: | :----------------------------------------------------------: | :--: |
|   1    | [setup Root RIB](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/1.%20setup%20Root%20RIB.md) |      |
|   2    | [LoggedOutRIB 만들기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/2.%20LoggedOutRIB%20만들기.md) |      |
|   3    | [LoggedInRIB 만들기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/3.%20LoggedInRIB%20만들기.md) |      |
|   4    | [MemosRIB 만들기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/4.%20MemosRIB%20만들기.md) |      |
|   5    | [AddMemoRIB 만들기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/5.%20AddMemoRIB%20만들기.md) |      |



### 심화

| Number |                            Title                             | Memo |
| :----: | :----------------------------------------------------------: | :--: |
|   6    | [앱을 launch할때, RootRIB에서 스위칭하는 립을 로그인 상태에 따라 설정해주기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/6.%20앱을%20launch할때%2C%20RootRIB에서%20스위칭하는%20립을%20로그인%20상태에%20따라%20설정해주기.md) |      |
|   7    | [MemosViewController에 로그아웃 버튼 달기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/7.%20MemosViewController에%20로그아웃%20버튼%20달기.md) |      |
|   8    | [LoggedOutViewController에도 네비게이션 달기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/8.%20LoggedOutViewController에도%20네비게이션%20달기.md) |      |
|   9    | LoggedOutViewController에 회원가입 버튼 달기 |    - 적으면서 안하고 바로 작업해서 문서가 없음  |
|   10    | [email을 MemosRIB에게 까지 주입해주기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/9.%20email을%20MemosRIB에게%20까지%20주입해주기.md) |    - [의존성 트리 포스팅](https://eunjin3786.tistory.com/116)에서 데이터 주입을 보여주기 위해 작성한 예제  |




### Unit Test
| Number |                            Title                             | Memo |
| :----: | :----------------------------------------------------------: | :--: |
|   1    | [RootRouterTests](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tutorials/RootRouterTests.md) |      |


## 5. 🍯 꿀팁 🍯
| Number |                            Title                             | Memo |
| :----: | :----------------------------------------------------------: | :--: |
|   1    | [Main.storyboard 파일을 제거하기](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tips/Main.storyboard%20파일을%20제거하기.md) |      |
|   2    | [storyboard 파일을 만들 때](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tips/storyboard%20파일을%20만들%20때.md) |      |
|   3    | [NavigationController를 쓰고 싶을때](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tips/NavigationController를%20쓰고%20싶을때.md) |      |
|   4    | [기본 modal style이나 navigation pop을 쓸때 꼭 챙겨야할 것](https://github.com/eunjin3786/SimpleMemo-RIBs/blob/feature/RIBs/MD/Tips/기본%20modal%20style이나%20navigation%20pop을%20쓸%20때%20꼭%20챙겨야할%20것.md) |      |
