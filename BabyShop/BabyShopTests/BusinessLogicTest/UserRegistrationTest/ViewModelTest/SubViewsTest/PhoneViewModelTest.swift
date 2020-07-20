import XCTest

@testable import BabyShop
class PhoneViewModelTest: XCTestCase {
    func testPhoneVM() {
        let phoneVM: PhoneViewModelProtocol = PhoneViewModel()

//        when
        let phone = "89267778888"

//        then
        let isPhoneCorrect = phoneVM.checkPhoneNumber(with: phone)

//        result
        XCTAssert(isPhoneCorrect)
        XCTAssert(phone == phoneVM.phoneNumber)
    }

}
