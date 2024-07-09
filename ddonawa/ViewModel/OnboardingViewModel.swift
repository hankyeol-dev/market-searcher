//
//  OnboardingViewModel.swift
//  ddonawa
//
//  Created by 강한결 on 7/9/24.
//

import Foundation

struct NicknameValidateOuput {
    let success: Bool
    let error: ValidateService.Errors?
}

final class OnboardingViewModel {
    var nicknameInput = Observable<String?>("")
    var nicknameOutput = Observable<NicknameValidateOuput>(NicknameValidateOuput(success: false, error: nil))
    
    init() {
        nicknameInput.bind("") { nickname in
            self.validateNickname(nickname)
        }
    }
    
    private func validateNickname(_ nickname: String?) {
        guard let nickname else { return }
        
        do {
            try ValidateService.validateNickname(nickname)
            
            nicknameOutput.value = NicknameValidateOuput(success: true, error: nil)
            
        } catch ValidateService.Errors.isEmpty {
            nicknameOutput.value = NicknameValidateOuput(success: false, error: .isEmpty)
        } catch ValidateService.Errors.isLowerThanTwo {
            nicknameOutput.value = NicknameValidateOuput(success: false, error: .isLowerThanTwo)
        } catch ValidateService.Errors.isContainNumber {
            nicknameOutput.value = NicknameValidateOuput(success: false, error: .isContainNumber)
        } catch ValidateService.Errors.isContainSpecialLetter {
            nicknameOutput.value = NicknameValidateOuput(success: false, error: .isContainSpecialLetter)
        } catch ValidateService.Errors.isOverTen {
            nicknameOutput.value = NicknameValidateOuput(success: false, error: .isOverTen)
        } catch {
            nicknameOutput.value = NicknameValidateOuput(success: false, error: nil)
        }
    }
}
