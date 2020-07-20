import UIKit
import SnapKit
import RxSwift

class GreetingAnimationView: UIView {
//    MARK:- Subviews
    private let rocketImageView = UIImageView()
    private let whiteSmokeImageView = UIImageView()
    private let swipeImageView = UIImageView()

//    MARK: - Consts
    private let insetForRocket: CGFloat = 100
    private let rocketWidth: CGFloat = 128
    private let rocketHeight: CGFloat = 210
    private let rocketBottomInset: CGFloat = 99
    private let whiteSmokeHeight: CGFloat = 163
    private let screenHeight = UIScreen.main.bounds.height

//    MARK: - RXStuff
    public let isAnimationEnd = PublishSubject<Bool>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBaseUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBaseUI() {
        self.isUserInteractionEnabled = true
        setWhiteSmoke()
        setRocket()
        setSwipe()
    }

    private func setWhiteSmoke() {
        self.addSubview(whiteSmokeImageView)
        whiteSmokeImageView.snp.makeConstraints { (make) in
            make.bottom.trailing.leading.equalToSuperview()
            make.height.equalTo(whiteSmokeHeight)
        }

        whiteSmokeImageView.image = UIImage(named: "whiteSmoke")
        whiteSmokeImageView.contentMode = .scaleAspectFit
    }

    private func setRocket() {
        self.addSubview(rocketImageView)
        rocketImageView.isUserInteractionEnabled = true
        rocketImageView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(rocketBottomInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(rocketWidth)
            make.height.equalTo(rocketHeight)
        }

        rocketImageView.image = UIImage(named: "rocket")
        rocketImageView.contentMode = .scaleAspectFit
        rocketImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(animateRocketSmoke)))
        animateRocket()
    }

    @objc private func animateRocketSmoke(_ recognizer: UIPanGestureRecognizer) {
        rocketImageView.layer.removeAllAnimations()
        guard let rocketView = recognizer.view else {return }
        let traslation = recognizer.translation(in: self)
        rocketView.center.y += traslation.y

        switch recognizer.state {
        case .ended:
            if rocketView.center.y <= self.center.y {
                UIView.animate(withDuration: 1.5, animations: {
                    rocketView.center.y = -100
                }) { _ in
                    rocketView.removeFromSuperview()
                    self.isAnimationEnd.onNext(true)
                }
            } else {
                UIView.animate(withDuration: 0.6, animations: {
                    rocketView.center.y = self.bounds.height - self.insetForRocket - self.rocketHeight/2
                }) { _ in
                    self.animateRocket()
                }
            }
        default:
            break
        }

        recognizer.setTranslation(.zero, in: self)
    }

    private func animateRocket() {
        let animation = CABasicAnimation(keyPath: "position.y")
        let insetForRocketCenter = screenHeight * 0.75
        animation.fromValue = insetForRocketCenter + 10
        animation.toValue = insetForRocketCenter - 10
        animation.duration = 1.5
        animation.repeatCount = Float.infinity

        rocketImageView.layer.add(animation, forKey: "rocket")
    }

    private func setSwipe() {
        self.addSubview(swipeImageView)
        swipeImageView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.top.equalToSuperview()

        }

        swipeImageView.image = UIImage(named: "swipe")
        swipeImageView.contentMode = .scaleAspectFit
    }
}
