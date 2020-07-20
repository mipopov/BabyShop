import RxSwift

protocol GreetingViewModelProtocol {
    var isAnimationEnd: BehaviorSubject<Bool> { get }
}

final class GreetingViewModel: GreetingViewModelProtocol {
    private let router: GreetingRouter

    var isAnimationEnd: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    private let disposeBag = DisposeBag()

    init(router: GreetingRouter) {
        self.router = router
        openAuthVC()
    }

    func openAuthVC() {
        isAnimationEnd
            .filter({$0})
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else {return }
                self.router.showAuthorizeScreen()
            })
            .disposed(by: disposeBag)
    }
}
