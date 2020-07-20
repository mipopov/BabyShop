import RxSwift
import RealmSwift

protocol AuthViewModelProtocol {
    var checkUser: PublishSubject<Void> { get }
    var userRegistration: PublishSubject<Void> { get }
    var forgetPassword: PublishSubject<Void> { get }
    var userName: BehaviorSubject<String> { get set }
    var password: BehaviorSubject<String> { get set }
}

class AuthViewModel: AuthViewModelProtocol {
    var userName: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var password: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var checkUser: PublishSubject<Void> = PublishSubject<Void>()
    var userRegistration: PublishSubject<Void> = PublishSubject<Void>()
    var forgetPassword: PublishSubject<Void> = PublishSubject<Void>()

    private let router: AuthRouter
    private let authNetService: AuthServiceProtocol

    var emailText = ""
    var passwordText = ""
    private let disposeBag = DisposeBag()

    init(router: AuthRouter, service: AuthServiceProtocol = AuthService()) {
        self.router = router
        self.authNetService = service

        checkUserAuth()
        changeValues()
        registrateUser()
        rememberPassword()
    }
    private func changeValues() {
        userName
            .subscribe(onNext: { [weak self] (name) in
                guard let self = self else {return }
                self.emailText = name
            })
            .disposed(by: disposeBag)

        password
            .subscribe(onNext: {[weak self] (pas) in
                guard let self = self else {return }
                self.passwordText = pas
            })
            .disposed(by: disposeBag)
    }
    private func rememberPassword() {
        forgetPassword
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else {return }
                self.router.showForgetScreen()
            })
            .disposed(by: disposeBag)
    }
    private func registrateUser() {
        userRegistration
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else {return }
                self.router.showRegistrationScreen()
            })
            .disposed(by: disposeBag)
    }
    private func checkUserAuth() {
        if let user = try? RealmService.get(UserRealm.self, primaryKey: emailText) {
            checkUser
                .subscribe(onNext: {[weak self] _ in
                    guard let self = self else {return }
                    self.makeRequest(with: user)
                })
                .disposed(by: disposeBag)
        } else {

        }
    }

    private func makeRequest(with user: UserRealm) {
        authNetService.authShop(email: user.email, password: user.password)
            .subscribe(onNext: { (resp) in
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    user.accesToken = resp.accesToken
                    user.expires = resp.expires
                    user.refreshToken = resp.refreshToken
                    try realm.commitWrite()
                } catch {
                    print(error)
                }
            }, onError: { err in
                print(err)
            })
            .disposed(by: disposeBag)

    }
}
