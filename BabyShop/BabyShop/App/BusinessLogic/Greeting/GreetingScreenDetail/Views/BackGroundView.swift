import UIKit
import SnapKit

class BackGroundView: UIView {
//    MARK: - Subviews
    private let starsImageView = UIImageView()
    private let blueSmokeImageView = UIImageView()
    private let greenSmokeImageView = UIImageView()
    private let shopNameImageView = UIImageView()

    private let blueSmokeHeight: CGFloat = 189
    private let greenSmokeHeight: CGFloat = 163
    private let shopNameWidth: CGFloat = 244
    private let shopNameHeight: CGFloat = 103
    private let shopNameLeftInset: CGFloat = 85
    private let shopNameTopInset: CGFloat = 307
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBaseUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupBaseUI() {
        self.backgroundColor = UIColor.spaceBackground
        setStarsView()
        setBlueSmoke()
        setGreenSmoke()
        setShopImageView()

    }
    private func setStarsView() {
        self.addSubview(starsImageView)

        starsImageView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }

        starsImageView.image = UIImage(named: "stars")
        starsImageView.contentMode = .scaleAspectFit
    }

    private func setBlueSmoke() {
        self.addSubview(blueSmokeImageView)
        blueSmokeImageView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(blueSmokeHeight)

        }
        blueSmokeImageView.image = UIImage(named: "blueSmoke")
        blueSmokeImageView.contentMode = .scaleAspectFit
    }

    private func setGreenSmoke() {
        self.addSubview(greenSmokeImageView)

        greenSmokeImageView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(greenSmokeHeight)
        }
        greenSmokeImageView.image = UIImage(named: "greenSmoke")
        greenSmokeImageView.contentMode = .scaleAspectFit
    }

    private func setShopImageView() {
        self.addSubview(shopNameImageView)

        shopNameImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(shopNameTopInset)
            make.leading.equalToSuperview().inset(shopNameLeftInset)
            make.width.equalTo(shopNameWidth)
            make.height.equalTo(shopNameHeight)
        }
        shopNameImageView.image = UIImage(named: "shopName")
        shopNameImageView.contentMode = .scaleAspectFit

    }
}
