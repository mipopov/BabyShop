import UIKit
import SnapKit

class ForgetPasswordView: UIView {
    private let forgetLabel = UILabel()
    private let messageLabel = UILabel()
    private let errorLabel = UILabel()
    let emailTextField = UITextField()
    let sendEmailButton = UIButton()

//    Properties for forgetLabel
    private let topInset: CGFloat = 106
    private let forgetLabelWidth: CGFloat = 286
    private let forgetLabelHeight: CGFloat = 34
    private let forgetPasswordText = "Забыли пароль"
    private let forgetPaswwordTextFont: CGFloat = 34

//  Properties for messageLabel
    private let topMessageInset: CGFloat = 87
    private let messageHeight: CGFloat = 40
    private let messageWidth: CGFloat = 343
    private let messageText = "Введите пожалуйста email \n и на вашу почту придет пароль"
    private let fontMessageSize: CGFloat = 14

//    Properties for emailTextField and Errorlabel
    private let emailWidth: CGFloat = 343
    private let emailHeight: CGFloat = 64
    private let topEmailInset: CGFloat = 16
    private let emailPlaceholder = "Введите email"
    private let emailCornerRadius: CGFloat = 4

    private let topErrorInset: CGFloat = 4
    private let widthError: CGFloat = 282
    private let heightError: CGFloat = 11
    private let textError = "Некорректный email"
    private let errorFonstSize: CGFloat = 11

//    Properties For button
    private let topButtonInset: CGFloat = 55
    private let buttonWidth: CGFloat = 343
    private let buttonHeight: CGFloat = 48
    private let buttonCornerRadius: CGFloat = 25
    private let buttonTitle = "Отправить"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseUI()
        self.backgroundColor = UIColor.spaceBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupForgetLabel()
    }

    private func setupBaseUI() {
        setPropertiesForgetLabel()
        setPropertiesMessageLabel()
        setPropertiesEmailField()
        setPropertiesError()
        setPropertiesSendButton()
    }
    private func setupForgetLabel() {
        self.addSubview(forgetLabel)

        forgetLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(topInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(forgetLabelWidth)
            make.height.equalTo(forgetLabelHeight)
        }
        setupMessageLabel()
    }
    private func setupMessageLabel() {
        self.addSubview(messageLabel)

        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(forgetLabel.snp.bottom).offset(topMessageInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(messageWidth)
            make.height.equalTo(messageHeight)
        }
        setupEmailField()
    }
    private func setupEmailField() {
        self.addSubview(emailTextField)

        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp.bottom).offset(topEmailInset)
            make.width.equalTo(emailWidth)
            make.height.equalTo(emailHeight)
            make.centerX.equalToSuperview()
        }
        setupErrorMessage()
    }

    private func setupErrorMessage() {
        self.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(topErrorInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(widthError)
            make.height.equalTo(heightError)
        }

        setupSendButton()
    }

    private func setupSendButton() {
        self.addSubview(sendEmailButton)

        sendEmailButton.snp.makeConstraints { (make) in
            make.top.equalTo(errorLabel.snp.bottom).offset(topButtonInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
        }
    }

    private func setPropertiesMessageLabel() {
        messageLabel.attributedText = NSAttributedString(string: messageText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontMessageSize), NSAttributedString.Key.foregroundColor: UIColor.white])

        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 2
    }
    private func setPropertiesForgetLabel() {
        forgetLabel.attributedText = NSAttributedString(string: forgetPasswordText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: forgetPaswwordTextFont), NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    private func setPropertiesEmailField() {
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = emailPlaceholder
        emailTextField.layer.cornerRadius = emailCornerRadius
        emailTextField.clipsToBounds = true
    }

    private func setPropertiesError() {
        errorLabel.textAlignment = .center
        errorLabel.attributedText = NSAttributedString(string: textError, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: errorFonstSize), NSAttributedString.Key.foregroundColor: UIColor.red])

    }

    private func setPropertiesSendButton() {
        sendEmailButton.setTitle(buttonTitle, for: .normal)
        sendEmailButton.backgroundColor = .red
        sendEmailButton.layer.cornerRadius = buttonCornerRadius
        sendEmailButton.clipsToBounds = true
    }
}
