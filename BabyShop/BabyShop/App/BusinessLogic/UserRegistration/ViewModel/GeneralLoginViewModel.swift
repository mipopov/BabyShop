import RxSwift
import RealmSwift

protocol GeneralLoginViewModelProtocol {
    var fullNameViewModel: FullNameViewModelProtocol {get set}
    var emailViewModel: EmailViewModelProtocol { get set }
    var phoneViewModel: PhoneViewModelProtocol { get set }
    var passwordViewModel: PasswordViewModelProtocol { get set }
    var registrateUserSubject: PublishSubject<Void> { get }

}

class GeneralLoginViewModel: GeneralLoginViewModelProtocol {
//    MARK: - Protocols
    var fullNameViewModel: FullNameViewModelProtocol
    var emailViewModel: EmailViewModelProtocol
    var phoneViewModel: PhoneViewModelProtocol
    var passwordViewModel: PasswordViewModelProtocol
    var registrateUserSubject: PublishSubject<Void> = PublishSubject<Void>()

    private let router: RegistrationRouter
    private let authNetService: AuthServiceProtocol

//  RX Stuff
    private let disposeBag = DisposeBag()

    init(router: RegistrationRouter,
         emailVM: EmailViewModelProtocol = EmailViewModel(),
         phoneVM: PhoneViewModelProtocol = PhoneViewModel(),
         passVM: PasswordViewModelProtocol = PasswordViewModel(),
         service: AuthServiceProtocol = AuthService(),
         userNameVM: FullNameViewModelProtocol = FullNameViewModel()) {
        self.router = router
        self.authNetService = service
        self.emailViewModel = emailVM
        self.phoneViewModel = phoneVM
        self.passwordViewModel = passVM
        self.fullNameViewModel = userNameVM
        registrateUser()
    }

    private func registrateUser() {
        registrateUserSubject
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else {return }
                self.makeRequest()
            })
            .disposed(by: disposeBag)
    }
    private func makeRequest() {
        let name = fullNameViewModel.name
        let surname = fullNameViewModel.surName
        let email = emailViewModel.email
        let pass = passwordViewModel.password
        let phone = phoneViewModel.phoneNumber
        authNetService
            .shopUserRegistration(name: name, surname: surname,
                                  email: email, password: pass, phone: phone)
            .subscribe(onNext: { [weak self] resp in
                guard let self = self else { return }
                self.addNewUserToRealm(with: name, surname: surname,
                                       email: email, pass: pass, phone: phone,
                                       exp: resp.expires, refrTok: resp.refreshToken,
                                       accesToken: resp.accesToken)
                self.router.showMainPage()
            })
            .disposed(by: disposeBag)
    }
    private func addNewUserToRealm(with name: String, surname: String,
                                   email: String, pass: String, phone: String,
                                   exp: Int, refrTok: String, accesToken: String) {
        let newUser = UserRealm(userName: name, surname: surname,
                                email: email, password: pass, phone: phone,
                                expires: exp, refreshTok: refrTok,
                                accesTok: accesToken)
        do {
            try RealmService.save(items: [newUser])
        } catch  let err as NSError {
            print("Something wrong with saving, \(err.localizedDescription)")
        }
    }
}
