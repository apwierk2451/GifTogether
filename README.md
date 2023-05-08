###### tags: `README`

# GifTogether

## 프로젝트 소개
선물받고 사용하지 않을 것 같은 기프티콘을 거래하는 거래소 어플리케이션 입니다. 
- [Figma 설계](https://www.figma.com/file/Na3WMF1xogSCv7pG3aBec5/GifTogether?node-id=0-1&t=OeuBTCYqEQSXoXAC-0)

## 📑 목차

- [🔑 핵심기술](#🔑-핵심기술)
- [📱 실행화면](#📱-실행화면)
- [🔭 프로젝트 구조](#🔭-프로젝트-구조)
- [⚙️ 적용한 기술](#⚙️-적용한-기술)
- [⚠️ 트러블 슈팅](#⚠️-트러블-슈팅)

## 🔑 핵심기술
- **`MVVM`**
    - MVVM 패턴
- **`UI 구현`**
    - SwiftUI
    - NavigationLink
- **`비동기처리`**
    - Combine
- **`이미지 캐싱`**
<br>
    
## 📱 실행화면
    
|HomeTab|SearchTab|FavoriteTab|MypageTab|
|:---:|:---:|:---:|:---:|
|<img src="" width="200">|<img src="" width="200">|<img src="" width="200">|<img src="" width="200">|

<br>
    
## 🔭 프로젝트 구조

### [Presentation Layer]
#### - <U>LoginScene</U>
#### - <U>HomeScene</U>
#### - <U>SearchScene</U>
#### - <U>FavoriteScene</U>
#### - <U>MyPageScene</U>

### [Domain Layer]
#### - <U>Entity</U>
#### - <U>UseCase</U>

### [Data Layer]
#### - <U>Repository</U>
#### - <U>Services</U>
#### - <U>PersistentStorages</U>



<br>
    
## ⚙️ 적용한 기술

### ✅ iOS 15
- 최근 4년동안 도입된 iOS기기 중 96%가 iOS 15버전 이상을 이용하고 있기에 iOS 15버전을 target으로 설정했습니다.
[<img src="https://i.imgur.com/5XUDpoN.png" width="300" height="400"/>](https://developer.apple.com/kr/support/app-store/)

### ✅ SwiftUI
- UI 구현에 SwiftUI 를 사용했습니다. 

### ✅ Firebase [<Wiki로 이동>](https://github.com/apwierk2451/GifTogether/wiki/Firebase)
- 회원가입, 전화번호 인증을 구현했습니다.
- 사용자 정보 원격 저장소를 구현했습니다.
- 기프티콘 정보 저장 원격 저장소를 구현했습니다.
- Firestorage를 이용해 사용자가 등록한 기프티콘 이미지를 저장했습니다.
### ✅ CoreData [<Wiki로 이동>](https://github.com/apwierk2451/GifTogether/wiki/CoreData)
- 검색 history 저장을 위해 CoreData 를 이용했습니다. 
- 내부적으로 maxCount를 지정하여 history 를 뽑아올 수 있습니다. 
- 최근 검색어를 기준으로 내림차순 정렬하도록 구현 했습니다. 

### ✅ VisionKit

- VisionKit을 이용하여 사진 분석 결과를 받아 데이터화하도록 이용했습니다.
- 본인 앨범에 있는 기프티콘을 등록 시 쿠폰번호와 유효기간 정보를 가져오도록 구현했습니다.

## ⚠️ 트러블 슈팅

### 🛠 TabBar 중복 탭시, 새로고침 하기 [<Wiki로 이동>]()
- 탭바 아이템 연속 탭시, 화면 최상단으로 스크롤되고 데이터를 리셋하는 사용자 경험을 제공하려는 목적이 있었습니다.
- HomeTab 의 select 파라미터에 Binding 변수를 적용해주어 해결 했습니다.

### 🛠 rootView 에 onTapGesture 적용 오류
- NavigationLink 에 onTapGesture 를 적용했을 때와 비슷한 오류로, Navigation 계층 rootView 에 onTapGesture를 걸어주니 모든 Navigation 이동에 문제가 생겼습니다. 
    - 탭뷰의 탭이 눌리지 않는 현상
    - 네비게이션바 뒤로가기 버튼이 눌리지 않는 현상

- 위와같은 문제가 발생하여 원인을 찾아보니 NavigationView 를 포함하는 RootView 에 onTapGesture 를 걸어준 것이 원인이었고, 제거하니 해결 되었습니다. 



## 🔗 References
- [Apple Docs - SwiftUI](https://developer.apple.com/documentation/swiftui/#essentials)
- [Table and Collection View Cells Reload Improvements in iOS 15](https://swiftsenpai.com/development/cells-reload-improvements-ios-15/)
- [VisionKit](https://developer.apple.com/documentation/visionkit)
- [Firebase - 전화번호 인증](https://firebase.google.com/docs/auth/ios/phone-auth?hl=ko&authuser=0)
