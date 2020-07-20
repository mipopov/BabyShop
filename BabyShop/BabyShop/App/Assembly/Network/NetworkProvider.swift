import Moya

enum NetworkProvider: TargetType {
    case login(email: String, password: String)
    case userRegistration(name: String, surname: String, email: String, password: String, phone: String)

    var baseURL: URL {
        return URL(string: Environment.rootURL)!
    }

    var path: String {
        switch self {
        case .login:
            return "auth/auth"
        case .userRegistration:
            return "auth/register"
        }
    }

    var method: Method {
        switch self {
        case .login:
            return .post
        case .userRegistration:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {

        case .login(let email, let password):
            return .requestParameters(parameters: [
                "email": email,
                "password": password
            ], encoding: URLEncoding())

        case .userRegistration(let name, let surname, let email, let password, let phone):
            return .requestParameters(parameters: ["name": name,
                                                   "surname": surname,
                                                   "email": email,
                                                   "password": password,
                                                   "phoneNumber": phone], encoding: URLEncoding())
        }

    }

    var headers: [String: String]? {
        return nil
    }

}
