import UIKit
import SnapKit

class ForgetPasswordViewController: UIViewController {
    private let forgetView = ForgetPasswordView()
    private let heightForView: CGFloat = 600

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(forgetView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setView()
    }

    private func setView() {
        forgetView.snp.makeConstraints({ $0.top.leading.trailing.bottom.equalToSuperview()})
    }
}
