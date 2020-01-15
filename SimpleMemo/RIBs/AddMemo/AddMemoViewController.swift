import RIBs
import RxSwift
import UIKit

protocol AddMemoPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func navigationBackDidTap()
    var saveMemo: PublishSubject<Memo> { get } 
}

final class AddMemoViewController: UIViewController, AddMemoPresentable, AddMemoViewControllable {
    
    @IBOutlet weak var addMemoTextField: UITextField!
    @IBOutlet weak var saveMemoButton: UIButton!

    weak var listener: AddMemoPresentableListener?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        saveMemoButton.rx.tap.withLatestFrom(addMemoTextField.rx.text.orEmpty)
            .filter { !$0.isEmpty }
            .map { return Memo(title: $0) }
            .subscribe(onNext: { [weak self] memo in
                self?.listener?.saveMemo.onNext(memo)
            }).disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            listener?.navigationBackDidTap()
        }
    }
}
