#  쇼핑 검색 앱 - 또나와 (ddonawa)

- 내가 사고 싶은 물건을 쉽게 검색해보세요!
- 나만의 프로필을 만들고, 검색한 물건을 나만의 장바구니 목록에 담아두세요

## Project Implementation Requirements

<details>
    <summary>요구사항 보기</summary>

    ### 프로젝트 기본 세팅 
    
    - [x] iOS 타겟: `iOS15+ / IPhone Portrait Only`
    - [x] 파일 세팅: Launch Screen을 제외한 모든 파일은 코드베이스의 Swift 파일로 구성
    - [x] API: 네이버 쇼핑 검색 오픈 API
    
    ### 0. 모델링 & 유틸리티 함수 작성
    - [x] User
    - [x] Product
    - [x] for UserDefaults Controller
    - [x] for API mapping
    - [x] for Array
    
    ### 1. 온보딩 페이지 - 프로필 세팅
    
    - 페이지 랜더링 기준
        - [x] 앱이 설치 후 최초로 실행되었을 때
        - [x] 유저 데이터가 조회되지 않을 경우 (온보딩 페이지에서 프로필 생성이 완료되지 않은 경우)
        - [x] 유저 데이터가 삭제된 경우 (설정 페이지에서 유저가 탈퇴한 경우)
        
    - 프로필 이미지
        - [x] 유저가 프로필 이미지를 선택하지 않은 경우 - 12가지 이미지 중 랜덤으로 표시
        - [x] 프로필 이미지 UI 터치 -> 2. 프로필 선택 페이지로 이동 -> 선택 후 다시 이전 페이지로 이동
        
    - 프로필 닉네임
        - [x] 2~10자로 글자 수 제한
        - [x] @, #, $, % 특수 문자 4개 사용 제한
        - [x] 닉네임 검증 -> 기준 미충족시 실시간으로 텍스트 필드 하단에 레이블 노출
            - [x] 조건 충족 : 정말 멋진 닉네임이에요!
            - [x] 글자 수 : 2자 이상 10자 이하의 닉네임으로 설정해주세요.
            - [x] 특수 문자 : 닉네임에 @, #, $, % 는 들어갈 수 없어요.
            - [x] 숫자 : 닉네임에 숫자는 들어갈 수 없어요.
            - [x] 빈 문자 : 멋진 닉네임을 작성해보세요. (추가)
            
    - 페이지 전환
        - [x] 닉네임 기준에 맞는 값이 설정된 경우만 전환 가능
            - [x] 닉네임 기준 미 충족시 버튼 자체를 터치할 수 없도록 설정
        - [x] 프로필 생성 전 이전 페이지로 전환시, 이미지 / 닉네임 모두 초기화 
    
    ### 2. 온보딩 페이지 - 프로필 이미지 설정
    
    - [x] 12가지 프로필 이미지가 컬랙션뷰로 보여짐
    - [x] 유저가 선택한 이미지가 컬랙션 뷰 상단에 노출됨
        - [x] 선택한 이미지의 tint color alpha 조절
    - [x] 이미지 선택 후 이전 1. 프로필 세팅 페이지로 이동
        
    ### 3. 메인 화면
    
    - [x] 페이지 네비게이션 바에 유저 이름 표기 (ex. OOO님의 또나와)
    - [x] 상단에 상품 검색바 노출
        - [x] 검색어 입력 후 검색 버튼 / Return 키 터치시 검색된 상품 노출 페이지로 이동
    
    - [x] 최근 검색어 여부에 따라 페이지 형태 변경
        - [x] 최근 검색어 없는 경우 -> 이미지 노출
        - [x] 최근 검색어 있는 경우 -> 최근 검색어 목록 테이블 뷰로 노출
    
    - 최근 검색어 있는 경우
        - [x] 최근에 검색한 검색어 순서대로 노출
        - [x] 검색어 셀의 X 버튼 터치시, 해당 셀의 검색어만 삭제
        - [x] 전체 삭제 버튼 터치시 전체 검색어 삭제
        - [x] 검색어 셀 터치시, 해당 검색어로 검색된 4. 상품 노출 페이지로 이동
    
    ### 4. 상품 검색 페이지
    
    - [x] 페이지 네비게이션 바에 검색어 표기 (ex. OOO)
    
    - 검색
        - [x] 네이버 쇼핑 검색 API를 활용하여 한 번에 30개씩 + 페이지네이션 처리
        - [x] 정확도순, 날짜순, 가격높은순, 가격낮은순 으로 필터링하는 버튼 구현 + 필터링
        - [x] 검색된 상품 총 갯수 노출 (ex. 0,000개의 OOO 검색!)
    
    - 검색 결과
        - [x] 검색 결과는 컬랙션 뷰로 노출
        - [x] 컬랙션 아이템은 이미지, 쇼핑몰 이름, 상품 이름, 가격으로 반영, 상품 이름은 최대 2줄까지 노출
        - [x] 컬랙션 아이템 이미지 위에 '장바구니 찜' 버튼 반영
            - [x] 장바구니 찜 버튼(이미지) 터치시 해당 데이터 유저 모델에 저장
            - [x] 장바구니 찜 저장 내역이 이후에도 계속 확인되어야 함 (productId 기반으로 저장)
        - [x] 컬랙션 아이템 터치 -> 5. 상품 상세 페이지 전환
    
    ### 5. 상품 상세 페이지
    
    - [x] 페이지 네비게이션 바에 선택된 상품명 반영
    - [x] 페이지 네비게이션 우측에 장바구니 찜 버튼 반영 (상품별 버튼 토글 상태 반영)
    
    ### 6. 유저 설정 페이지
    
    - [x] 프로필 이미지, 닉네임, 가입 날짜 반영된 프로필 정보 뷰 반영
        - [x] 해당 뷰 터치시 7. 프로필 정보 수정 페이지로 전환
    
    - 유저 설정 테이블 뷰
        - [x] 장바구니 찜 갯수 노출
        - [x] 자주 묻는 질문, 1:1 문의, 알림 설정 셀 - 터치해도 이벤트 없음
        - [x] 탈퇴하기 
            - [x] 해당 셀 터치시 Alert Action (확인, 취소)
            - [x] 확인 - 데이터 삭제 후 온보딩 페이지로 이동
            - [x] 취소 - 6. 유저 설정 페이지 유지
    
    ### 7. 프로필 정보 수정 페이지
    
    - [x] 1, 2의 프로필 세팅 페이지를 프로필 수정 페이지로 재활용 필요
    - [x] 페이지 네비게이션 바 우측에 '저장' 버튼 반영 -> 터치 시 정보 저장 후 6. 유저 설정 페이지로 이동
    - 기타 다른 기능은 모두 1, 2의 프로필 세팅 페이지와 동일

</details>

## Project Advanced Implementation Requirements

<details open>
    <summary>요구사항 보기</summary>
    
    - [x] 1에서 프로필 닉네임 랜덤 생성 버튼 추가
    - [ ] 4에서 API로 검색 결과 Fetching 중인 경우 Skeleton UI 보여주기
    - [x] 4에서 API 통신 결과가 Error 일 경우 에러난 상태 보여주기 (ex. toast)
    - [ ] 6에서 장바구니 찜 셀 터치시 4의 상품 검색 페이지처럼 보여주기 
    - [ ] for API Networking (async, await, task, do-try 반영해보기)
    
</details>


## 또나와 살펴보기

(TBD)
