//
//  Text.swift
//  ddonawa
//
//  Created by 강한결 on 6/13/24.
//

import Foundation

enum Texts: String {
    
    case APP_NAME = "또나와"
    case APP_NAME_EN = "DDONAWA"
    
    enum Navigations: String {
        case ONBOARDING_PROFILE_SETTING = "프로필 설정하기"
    }
    
    enum Placeholders: String {
        case ONBOARDING_NICK = "닉네임을 입력해주세요 :)"
        case SEARCHING_PRODUCT = "브랜드, 상품 등을 입력하세요."
    }
    
    enum Buttons: String {
        case ONBOARDING_START = "시작하기"
        case ONBOARDING_CONFIRM = "완료"
        case RECENTSEARCHING_DELETE_BTN = "전체 삭제"
    }
    
    enum Indicator: String {
        case NICKNAME_EDITING_START = " "
        case NICKNAME_ERROR_EMPTY = "멋진 닉네임을 작성해보세요."
        case NICKNAME_ERROR_COUNT = "닉네임은 2자 이상 10자 이하로 작성해주세요."
        case NICKNAME_ERROR_SPECIAL_LETTER = "닉네임에 @, #, $, % 는 들어갈 수 없어요."
        case NICKNAME_ERROR_NUMBER = "닉네임에 숫자는 들어갈 수 없어요."
        case NICKNAME_SUCCESS = "정말 멋진 닉네임이에요!"
    }
    
    enum Menu: String {
        case RECENTSEARCHING = "최근 검색"
    }
}
