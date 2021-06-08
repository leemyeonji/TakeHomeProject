# TakeHomeProject_GithubFollower
![github2](https://user-images.githubusercontent.com/61834038/121122236-09afe180-c85c-11eb-9dfd-e58b57c1b39f.png)

Sean Allen 의 Take home project 입니다. 
깃허브 유저 ID 검색을 통해 팔로워 리스트와 유저의 정보를 볼 수 있습니다.
또한 유저를 나의 Favorite 리스트에 추가할 수 있는 기능을 갖춘 어플리케이션입니다.

# What I learned from this project

**No storyboard**
  - 스토리보드 없이 100% 코드만을 이용하여 UI를 구성했습니다

**No third party libraries**
  - Third party libraries 를 사용하지 않고 네트워킹과 키보드 인터렉션을 구현했습니다

**Dark Mode**
  - System Font와 System Color를 이용하여 다크모드에 대응했습니다

**Custom Alert / Custom Error Message**
  - Custom Error 메세지를 통해 유저에게 localizeDesciption을 노출하지 않도록 했습니다

**"Design Pattern is not a template"**
  - Design Pattern은 끼워 맞추어야하는 주형이 아닌 코드를 효율적으로 만들기 위해 '있어야할 곳'에 위치시키는 것이라는 걸 배웠습니다

**Asynchronuous Network Calls, URLSession, Codable, ARC**
  - 네트워킹과 그에 따라 후행하는 UI 업데이트를 배웠습니다. 또한 컨트롤러에서 이루어지는 네트워크 클로저에서 발생하는 메모리 누수를 관리했습니다

**Result Type**
  - Swift 5에서 제공하는 result type을 이용하여 네트워크 코드를 관리하였습니다

**CollectionViews, DiffableDataSource, Snapshot**
  - 디바이스의 사이즈와 제각기 다른 정보에 대응하는 컬렉션뷰를 구현하였습니다

**Downloading User images, NSCache**
  - 외부 라이브러리의 도움 없이 유저의 Profile Image를 다운로드 하였고 Caching 또한 구현했습니다

**Detecing bottom of UIScrollVIew**
  - ScrollView delegate를 이용하여 pagination을 구현했습니다

**ChildViewController**
  - 코드를 이용하여 childview를 subview로 만들었습니다

**Persistance, UITableView, UIStackView, DateFormatter**

**Optimization**
  - 기능 구현 이후로 자주 사용하는 코드를 함수로 정리하고 UI 버그에 대응했습니다.  
