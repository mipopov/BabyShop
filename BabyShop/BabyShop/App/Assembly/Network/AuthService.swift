import Moya
import RxSwift

protocol AuthServiceProtocol {
    func authShop(email: String, password: String) -> Observable<UserAuthResponse>
    func shopUserRegistration(name: String, surname: String, email: String,
                              password: String, phone: String) -> Observable<UserAuthResponse>
}

final class AuthService: AuthServiceProtocol {
    private let provider = MoyaProvider<NetworkProvider>()
    private let queue = DispatchQueue(label: "spaceShopLogin")

    func authShop(email: String, password: String) -> Observable<UserAuthResponse> {
        let token: NetworkProvider = .login(email: email, password: password)

        return provider.rx
            .request(token, callbackQueue: queue)
            .map(UserAuthResponse.self)
            .asObservable()
    }

    func shopUserRegistration(name: String, surname: String, email: String,
                              password: String, phone: String) -> Observable<UserAuthResponse> {
        let token: NetworkProvider = .userRegistration(name: name,
                                                       surname: surname,
                                                       email: email,
                                                       password: password,
                                                       phone: phone)
        return provider.rx
            .request(token, callbackQueue: queue)
            .map(UserAuthResponse.self)
            .asObservable()
    }
}
