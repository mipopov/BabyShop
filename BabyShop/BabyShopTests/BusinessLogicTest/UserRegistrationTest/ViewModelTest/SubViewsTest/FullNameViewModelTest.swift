import XCTest
@testable import BabyShop

class FullNameViewModelTest: XCTestCase {

    func testFullNameVM() {
        let fullNameVM: FullNameViewModelProtocol = FullNameViewModel()

//        when
        let name = "Maxim"
        let surname = "Popov"

//        then
        let isNameCorrect = fullNameVM.checkUserName(with: name)
        let isSurnameCorrect = fullNameVM.checkSurname(with: surname)

        let testName = fullNameVM.name
        let testSurname = fullNameVM.surName

//        result
        XCTAssert(isNameCorrect)
        XCTAssert(isSurnameCorrect)
        XCTAssert(testName == name)
        XCTAssert(testSurname == surname)
    }

}
