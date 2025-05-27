
import UIKit

class CameraViewController: UIViewController {

    private var contentView: CameraView = .init()
    private let viewModel: CameraViewModel

//    private var cancellables = Set<AnyCancellable>()

    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.title = "Camera"

    }

}
