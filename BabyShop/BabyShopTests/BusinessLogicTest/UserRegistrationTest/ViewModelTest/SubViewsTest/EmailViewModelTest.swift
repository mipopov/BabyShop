import XCTest
@testable import BabyShop

class EmailViewModelTest: XCTestCase {
    func testEmailVM() {
        let emailVM = EmailViewModel()
//        when
        let email = "abcd@mail.com"
//        then
        let isEmailCorrect = emailVM.checkField(email: "abcd@mail.com")
        let testEmail = emailVM.email

//        result
        XCTAssert(isEmailCorrect)
        XCTAssert(email == testEmail)
    }

}
