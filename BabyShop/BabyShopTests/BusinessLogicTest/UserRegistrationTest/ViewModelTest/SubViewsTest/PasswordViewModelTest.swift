import XCTest
@testable import BabyShop

class PasswordViewModelTest: XCTestCase {
    func testPasswordTest() {
        let passwordVM: PasswordViewModelProtocol = PasswordViewModel()

//        when
        let password = "qwerty"
        let confirmPassword = "qwerty"

//        then
        let isPasswordCorrect = passwordVM.checkPasswords(with: password, and: confirmPassword)

//      result
        XCTAssert(isPasswordCorrect)
        XCTAssert(password == passwordVM.password)
    }

}
