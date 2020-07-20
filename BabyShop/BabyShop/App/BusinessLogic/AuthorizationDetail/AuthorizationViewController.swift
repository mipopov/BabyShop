import UIKit
import SnapKit
import RxSwift

class AuthorizationViewController: UIViewController {
    private let baseView = AuthoriztionView()
    var authViewModel: AuthViewModelProtocol!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }
    private func bindUI() {
        bindFields()
        bindButtons()
    }

    private func bindFields() {
        baseView.authView
            .userNameTextField
            .rx.text.orEmpty
            .bind(to: authViewModel.userName)
            .disposed(by: disposeBag)

        baseView.authView
            .passwordTextField
            .rx.text.orEmpty
            .bind(to: authViewModel.password)
            .disposed(by: disposeBag)

    }

    private func bindButtons() {
        baseView.authView
            .loginButton
            .rx.tap
            .bind(to: authViewModel.checkUser)
            .disposed(by: disposeBag)

        baseView.authView
            .registrationButton
            .rx.tap
            .bind(to: authViewModel.userRegistration)
            .disposed(by: disposeBag)

        baseView.authView
            .forgetPaswordButton
            .rx.tap
            .bind(to: authViewModel.forgetPassword)
            .disposed(by: disposeBag)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setView()
    }

    private func setView() {
        self.view.addSubview(baseView)
        baseView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.top.equalToSuperview()
        }
    }
}
