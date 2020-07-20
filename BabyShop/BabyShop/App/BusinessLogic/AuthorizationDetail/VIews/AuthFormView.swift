import UIKit
import SnapKit
import RxCocoa
import RxSwift

class AuthFormView: UIView {
    //    MARK:- Public Subviews
    public let userNameTextField = UITextField()
    public let passwordTextField = UITextField()
    public let loginButton = UIButton()
    public let registrationButton = UIButton()
    public let forgetPaswordButton = UIButton()

    //    MARK:- Private Subviews
    private let firstLineView = UIView()
    private let secondLineView = UIView()
    private let thirdLineView = UIView()

    //    MARK: - Consts
    private let insetForView: CGFloat = 10
    private let fieldHeight: CGFloat = 70
    private let lineHeight: CGFloat = 1
    private let buttonHeight: CGFloat = 25
    private let buttonCornerRadius: CGFloat = 10
    private let userNamePlaceholder = "Имя пользователя"
    private let passwordPlaceholder = "Пароль"
    private let loginButtonText = "Войти"
    private let forgetPasswordText = "Забыли пароль?"
    private let registrationText = "Зарегистрироваться"

//    MARK: - RXStuff
    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.setupBaseUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBaseUI() {
        setUserNameFieldAndLineView()
        setPasswordFieldAndLineView()
        setForgetButton()
        setLoginButton()
        setRegitrButton()
        isLoginButtonActive()
    }
    private func setUserNameFieldAndLineView() {
        self.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(insetForView)
            make.height.equalTo(fieldHeight)
        }
        userNameTextField.textColor = .white
        userNameTextField.attributedPlaceholder = NSAttributedString(string: userNamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.authField])
        userNameTextField.backgroundColor = .clear
        userNameTextField.returnKeyType = .done

        self.addSubview(firstLineView)
        firstLineView.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(insetForView)
            make.height.equalTo(lineHeight)
        }

        firstLineView.backgroundColor = .white
    }

    private func setPasswordFieldAndLineView() {
        self.addSubview(passwordTextField)

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firstLineView).offset(2*insetForView)
            make.leading.trailing.equalToSuperview().inset(insetForView)
            make.height.equalTo(fieldHeight)
        }
        passwordTextField.textColor = .white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.authField])
        passwordTextField.backgroundColor = .clear

        self.addSubview(secondLineView)
        secondLineView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(insetForView)
            make.height.equalTo(lineHeight)
        }
        secondLineView.backgroundColor = .white
    }
    private func setForgetButton() {
        self.addSubview(forgetPaswordButton)

        forgetPaswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(secondLineView.snp.bottom).offset(insetForView)
            make.centerX.equalTo(secondLineView.snp.centerX)
            make.height.equalTo(buttonHeight)
        }

        forgetPaswordButton.setTitle(forgetPasswordText, for: .normal)
        forgetPaswordButton.setTitleColor(.white, for: .normal)

    }
    private func setLoginButton() {
        self.addSubview(loginButton)

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(forgetPaswordButton.snp.bottom).offset(insetForView)
            make.leading.trailing.equalToSuperview().inset(insetForView)
            make.height.equalTo(2*buttonHeight)
        }
        loginButton.backgroundColor = .white
        loginButton.setAttributedTitle(NSAttributedString(string: loginButtonText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24), NSAttributedString.Key.foregroundColor: UIColor.loginButton]), for: .normal)

        loginButton.layer.cornerRadius = buttonCornerRadius
        loginButton.clipsToBounds = true

    }
    private func setRegitrButton() {
        self.addSubview(registrationButton)
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(insetForView)
            make.centerX.equalToSuperview()
            make.height.equalTo(2*buttonHeight)
        }
        registrationButton.setTitleColor(.white, for: .normal)
        registrationButton.setTitle(registrationText, for: .normal)

        self.addSubview(thirdLineView)
        thirdLineView.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(insetForView)
            make.height.equalTo(lineHeight)
        }
        thirdLineView.backgroundColor = .white
    }

    private func isLoginButtonActive() {
        let userNameText = userNameTextField.rx.text.orEmpty.asObservable()
        let passwordText = passwordTextField.rx.text.orEmpty.asObservable()

        let isButtonEnable = Observable
            .combineLatest(userNameText, passwordText)
            .map({$0.0.count > 3 && $0.1.count > 3})

        isButtonEnable
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        isButtonEnable.map({$0 ? 0.85 : 0.2})
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
    }
}
