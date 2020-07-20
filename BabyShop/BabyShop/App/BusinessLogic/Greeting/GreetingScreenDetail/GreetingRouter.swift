final class GreetingRouter: BaseRouter {
    func showAuthorizeScreen() {
        let authVC = AuthorizationViewController()
        let router = AuthRouter(viewController: authVC)
        authVC.authViewModel = AuthViewModel(router: router)
        viewController?.navigationController?.pushViewController(authVC, animated: true)
    }
}
