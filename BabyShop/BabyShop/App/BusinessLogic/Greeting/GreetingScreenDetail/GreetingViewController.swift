import UIKit
import SnapKit
import RxCocoa
import RxSwift

class GreetingViewController: UIViewController {
    var greetingViewModel: GreetingViewModelProtocol!
    private let baseBackGround = BackGroundView()
    private let rocketView = GreetingAnimationView()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setViews()
    }

    private func binding() {
        rocketView
            .isAnimationEnd
            .bind(to: greetingViewModel.isAnimationEnd)
            .disposed(by: disposeBag)
    }

    private func setViews() {
        self.view.addSubview(baseBackGround)
        baseBackGround.addSubview(rocketView)

        baseBackGround.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.top.equalToSuperview()
        }
        rocketView.snp.makeConstraints { (make) in
            make.bottom.leading.top.trailing.equalToSuperview()
        }
    }

}
