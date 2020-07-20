import UIKit
import AloeStackView
import SnapKit
import RxSwift
import RxCocoa

class RegistrationAloeViewController: AloeStackViewController {
    //    MARK: - Subviews
    private let registrationFormView = RegistrationView()
    var loginViewModel: GeneralLoginViewModelProtocol!
    //    MARK: - lazy Properties
    private lazy var email = registrationFormView.emailTextField.rx.text.orEmpty.asObservable()
    private lazy var userName = registrationFormView.nameTextField.rx.text.orEmpty.asObservable()
    private lazy var surName = registrationFormView.surnameTextField.rx.text.orEmpty.asObservable()
    private lazy var phone = registrationFormView.phoneTextField.rx.text.orEmpty.asObservable()
    private lazy var pass = registrationFormView.passwordTextField.rx.text.orEmpty.asObservable()
    private lazy var confirmPass = registrationFormView.confirmPasswordTextField.rx.text.orEmpty.asObservable()
    // Const
    private let registrationFormHeight: CGFloat = 700
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.stackView.addRow(registrationFormView)
        bindingLoginButton()
        bindChangeEmailColors()
        bindChangePasswordColors()
        bindChangeNameSurnameColors()
        bindPhoneChangeColors()
    }

    private func bindingLoginButton() {
        let isLoginButtonEnable = Observable
            .combineLatest(userName, surName, phone, email, pass, confirmPass)
            .map({[weak self] (name, surname, phone, email, pas, confpas) -> Bool in
                guard let self = self else {return false}
                return
                    self.loginViewModel.fullNameViewModel.checkUserName(with: name)
                        && self.loginViewModel.fullNameViewModel.checkSurname(with: surname)
                        && self.loginViewModel.phoneViewModel.checkPhoneNumber(with: phone)
                        && self.loginViewModel.emailViewModel.checkField(email: email)
                        &&  self.loginViewModel.passwordViewModel.checkPasswords(with: pas, and: confpas)
            })

        isLoginButtonEnable
            .bind(to: registrationFormView.loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        isLoginButtonEnable
            .map({$0 ? 0.85 : 0.2})
            .bind(to: registrationFormView.loginButton.rx.alpha)
            .disposed(by: disposeBag)

        registrationFormView
            .loginButton
            .rx.tap
            .bind(to: loginViewModel.registrateUserSubject)
            .disposed(by: disposeBag)
    }

    private func bindPhoneChangeColors() {
        let isPhoneCorrect = phone.map {[weak self] (phon) -> Bool in
            guard let self = self else {return false }
            return self.loginViewModel.phoneViewModel.checkPhoneNumber(with: phon)
        }

        isPhoneCorrect
            .map({$0 ? UIColor.green : UIColor.white})
            .bind(to: registrationFormView.phoneTextField.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    private func bindChangeEmailColors() {
        let isEmailCorrect = email
            .map {[weak self] (mail) -> Bool in
                guard let self = self else {return false }
                return self.loginViewModel.emailViewModel.checkField(email: mail)
        }

        isEmailCorrect
            .map({$0 ? UIColor.green : UIColor.white })
            .bind(to: registrationFormView.emailTextField.rx.backgroundColor)
            .disposed(by: disposeBag)
    }

    private func bindChangeNameSurnameColors() {
        let isNameCorrect = userName.map({$0.count > 0})

        isNameCorrect
            .map({$0 ? UIColor.green : UIColor.white})
            .bind(to: registrationFormView.nameTextField.rx.backgroundColor)
            .disposed(by: disposeBag)

        let isSurnameCorrect = surName.map({$0.count > 0})

        isSurnameCorrect.map({$0 ? UIColor.green : UIColor.white})
            .bind(to: registrationFormView.surnameTextField.rx.backgroundColor)
            .disposed(by: disposeBag)
    }

    private func bindChangePasswordColors() {
        let isPasswordCorrect = Observable
            .combineLatest(pass, confirmPass)
            .map {[weak self] (pass, confPass) -> Bool in
                guard let self = self else {return false }
                return self.loginViewModel.passwordViewModel.checkPasswords(with: pass, and: confPass)
        }
        
        isPasswordCorrect
            .map({$0 ? UIColor.green : UIColor.white})
            .bind(to: registrationFormView.passwordTextField.rx.backgroundColor)
            .disposed(by: disposeBag)

        isPasswordCorrect.map({$0 ? UIColor.green : UIColor.white})
            .bind(to: registrationFormView.confirmPasswordTextField.rx.backgroundColor)
            .disposed(by: disposeBag)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        registrationFormView.snp.makeConstraints { $0.height.equalTo(registrationFormHeight)}
    }
}

