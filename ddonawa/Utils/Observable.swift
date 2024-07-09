//
//  Observable.swift
//  ddonawa
//
//  Created by 강한결 on 7/9/24.
//

import Foundation

final class Observable<T> {
    private var handler: ((T) -> ())?
    
    var value: T {
        didSet {
            // 2. 초기화를 통해 값이 세팅되었지만, handler가 현재 할당되지 않은 상태라 nil로 평가됨
            self.handler?(self.value)
        }
    }
    
    init(_ value: T) {
        self.value = value // 1. Observable 인스턴스 멤버 변수 value에 값이 들어오면서 타입이 결정된다.
    }
    
    // 3. Observable 인스턴스로 bind 메서드를 호출
    // => 첫 인자로 들어온 값을 클로저 구현부의 로직에 맞게 핸들링
    // => 그 핸들링한 로직을 앞으로의 handler 클로저에 맵핑함
    func bind(_ value: T, handler: @escaping (T) -> ()) {
        handler(value)
        self.handler = handler // 4. self.vlaue의 값이 바뀌면, 여기서 맵핑된 클로저 로직이 자연스럽게 돌아감 (didSet에 묶여 있기 때문)
    }
}
