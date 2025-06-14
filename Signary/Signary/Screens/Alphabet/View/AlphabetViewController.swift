
import UIKit

class AlphabetViewController: UIViewController {

    private var contentView: AlphabetView = .init()
    private let viewModel: AlphabetViewModel

    init(viewModel: AlphabetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        NavigationBarAppearanceConfiguration.applyTitleView(to: navigationItem)

    }

}
