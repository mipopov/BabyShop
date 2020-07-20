import UIKit
import SnapKit

class RegistrationView: UIView {
    let nameTextField = UITextField()
    let surnameTextField = UITextField()
    let emailTextField = UITextField()
    let phoneTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let loginButton = UIButton()

    private let leftRightInset: CGFloat = 16
    private let widthFields: CGFloat = 343
    private let heightFields: CGFloat = 64
    private let insetBetweenFileds: CGFloat = 8
    private let nameFieldPlaceholder = "Введиете ваше имя"
    private let surnameFieldPlaceholder = "Введите вашу фамилию"
    private let phoneFieldPlaceholder = "89991111212"
    private let emailFieldPlaceholder = "Введите ваш enail"
    private let passwordFieldPlaceholder = "Введите пароль"
    private let confirmFieldPlaceholder = "Повторите пароль"

    private let topInsetForButton: CGFloat = 70
    private let leftRightInsetForButton: CGFloat = 16
    private let buttonWidth: CGFloat = 343
    private let buttonHeight: CGFloat = 48
    private let loginButtonCornerRadius: CGFloat = 25
    private let loginButtonTitle = "Зарегистрироваться"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setNameSurName()
        setEmailAndPhoneFields()
        setPasswordFields()
        setLoginButton()
    }

    private func setupBaseUI() {
        setupPropertiesForNameFields()
        setupPropertiesForEmailAndPhone()
        setupPasswordFieldsProperties()
        setupPropertiesForLoginButton()
    }

    private func setNameSurName() {
        self.addSubview(nameTextField)
        self.addSubview(surnameTextField)

        nameTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(insetBetweenFileds)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(heightFields)
        }

        surnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(insetBetweenFileds)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(heightFields)
        }
    }
    private func setupPropertiesForNameFields() {
        nameTextField.backgroundColor = .white
        nameTextField.placeholder = nameFieldPlaceholder
        nameTextField.returnKeyType = .done
        nameTextField.textAlignment = .center

        surnameTextField.backgroundColor = .white
        surnameTextField.placeholder = surnameFieldPlaceholder
        surnameTextField.returnKeyType = .done
        surnameTextField.textAlignment = .center
    }

    private func setEmailAndPhoneFields() {
        self.addSubview(phoneTextField)
        self.addSubview(emailTextField)

        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(surnameTextField.snp.bottom).offset(insetBetweenFileds)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(heightFields)
        }
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneTextField.snp.bottom).offset(insetBetweenFileds)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(heightFields)
        }
    }
    private func setupPropertiesForEmailAndPhone() {
        phoneTextField.backgroundColor = .white
        phoneTextField.placeholder = phoneFieldPlaceholder
        phoneTextField.returnKeyType = .done
        phoneTextField.textAlignment = .center
        phoneTextField.keyboardType = .numberPad

        emailTextField.backgroundColor = .white
        emailTextField.placeholder = emailFieldPlaceholder
        emailTextField.returnKeyType = .done
        emailTextField.textAlignment = .center
    }

    private func setPasswordFields() {
        self.addSubview(passwordTextField)
        self.addSubview(confirmPasswordTextField)

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(insetBetweenFileds)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(heightFields)
        }
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(insetBetweenFileds)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(heightFields)
        }
    }

    private func setupPasswordFieldsProperties() {
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = passwordFieldPlaceholder
        passwordTextField.returnKeyType = .done
        passwordTextField.textAlignment = .center

        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.placeholder = confirmFieldPlaceholder
        confirmPasswordTextField.returnKeyType = .done
        confirmPasswordTextField.textAlignment = .center
    }

    private func setLoginButton() {
        self.addSubview(loginButton)

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(topInsetForButton)
            make.leading.trailing.equalToSuperview().inset(leftRightInset)
            make.height.equalTo(buttonHeight)
        }
    }

    private func setupPropertiesForLoginButton() {
        loginButton.layer.cornerRadius = loginButtonCornerRadius
        loginButton.clipsToBounds = true
        loginButton.setTitle(loginButtonTitle, for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .white
    }
}
