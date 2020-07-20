import XCTest
@testable import BabyShop
import RxSwift

class MockEmailViewModel: EmailViewModelProtocol {
    func checkField(email: String) -> Bool {
        return true
    }

    var email: String = "asd@mail.com"
}

class MockFullNameViewModel: FullNameViewModelProtocol {
    func checkUserName(with name: String) -> Bool {
        return true
    }

    func checkSurname(with surname: String) -> Bool {
        return true
    }

    var name: String = "maxim"

    var surName: String = "popov"

}
class MockPhoneViewModel: PhoneViewModelProtocol {
    func checkPhoneNumber(with phone: String) -> Bool {
        return true
    }

    var phoneNumber: String = "89267778888"
}

class MockPasswordViewModel: PasswordViewModelProtocol {
    func checkPasswords(with password: String, and confirmPas: String) -> Bool {
        return true
    }

    var password: String = "qwerty"
}
class MockRouter: RegistrationRouter {

}
class MockAuthService: AuthServiceProtocol {
    func authShop(email: String, password: String) -> Observable<UserAuthResponse> {
        return Observable.just(UserAuthResponse(expires: 21, refreshToken: "aaaaaaa", accesToken: "bbbbbbb"))
    }

    func shopUserRegistration(name: String, surname: String, email: String, password: String, phone: String) -> Observable<UserAuthResponse> {
        return Observable.just(UserAuthResponse(expires: 21, refreshToken: "aaaaaaa", accesToken: "bbbbbbb"))
    }

}
class GeneralViewModelTest: XCTestCase {
    func testGeneralVM() {
        let mockEmailVM: EmailViewModelProtocol = MockEmailViewModel()
        let mockFullNameVM: FullNameViewModelProtocol = MockFullNameViewModel()
        let mockPhoneVM: PhoneViewModelProtocol = MockPhoneViewModel()
        let mockpasswordVM: PasswordViewModelProtocol = MockPasswordViewModel()
        let router = MockRouter(viewController: UIViewController())
        let service: AuthServiceProtocol = MockAuthService()

        let generalVM: GeneralLoginViewModelProtocol = GeneralLoginViewModel(router: router,
                                                                             emailVM: mockEmailVM,
                                                                             phoneVM: mockPhoneVM,
                                                                             passVM: mockpasswordVM,
                                                                             service: service,
                                                                             userNameVM: mockFullNameVM)
//            when
        let expires = 21
        let refreshToken = "aaaaaaa"
        let accesToken = "bbbbbbb"

//        then

        generalVM.registrateUserSubject.onNext(Void())

//        result

    }

}
