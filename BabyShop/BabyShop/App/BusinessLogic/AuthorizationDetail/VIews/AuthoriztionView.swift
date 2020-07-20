import UIKit
import SnapKit

class AuthoriztionView: UIView {
//    MARK:- Subviews
    private let starsImageView = UIImageView()
    private let rocketImageView = UIImageView()
    public let authView = AuthFormView()

//    MARK:- Const
    private let topInsetForAuthView: CGFloat = 200
    private let insetForView: CGFloat = 20
    private let authViewHeight: CGFloat = 400
    private let rocketWidth: CGFloat = 100
    private let rocketHeight: CGFloat = 48

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.setupBaseUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBaseUI() {
        self.backgroundColor = UIColor.spaceBackground
        setStarsView()
        setAuthForm()
        animateRocket()
    }

    private func setStarsView() {
        self.addSubview(starsImageView)

        starsImageView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }

        starsImageView.image = UIImage(named: "stars")
        starsImageView.contentMode = .scaleAspectFit
    }

    private func setAuthForm() {
        self.addSubview(authView)
        authView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(topInsetForAuthView)
            make.leading.trailing.equalToSuperview().inset(3*insetForView)
            make.height.equalTo(authViewHeight)
        }
    }

    private func animateRocket() {
        self.addSubview(rocketImageView)
        rocketImageView.isUserInteractionEnabled = false
        rocketImageView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(5*insetForView)
            make.width.equalTo(rocketWidth)
            make.height.equalTo(rocketHeight)
        }
        rocketImageView.image = UIImage(named: "horizontalRocket")

        let animtion = CABasicAnimation(keyPath: "position.x")
        animtion.fromValue = 0
        animtion.toValue = UIScreen.main.bounds.width
        animtion.duration = 120.0

        rocketImageView.layer.add(animtion, forKey: "animatePositionForAuthScreen")
    }
}
