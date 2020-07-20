import UIKit

final class AuthRouter: BaseRouter {

    func showRegistrationScreen() {
        let registrationVC = RegistrationAloeViewController()
        let registrRouter = RegistrationRouter(viewController: registrationVC)
        registrationVC.loginViewModel = GeneralLoginViewModel(router: registrRouter)
        viewController?.navigationController?.navigationBar.isHidden = false
        viewController?.navigationController?.pushViewController(registrationVC, animated: true)
    }
    func showForgetScreen() {
        let forgetVC = ForgetPasswordViewController()
//        let forgetRouter = ForgetPasswordRouter(viewController: forgetVC)
        viewController?.navigationController?.pushViewController(forgetVC, animated: true)
    }

    func showMainPage() {

    }
}
