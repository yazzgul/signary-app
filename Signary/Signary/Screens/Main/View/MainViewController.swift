
import UIKit

class MainViewController: UIViewController {

    private var contentView: MainView = .init()
    private let viewModel: MainViewModel

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.title = "Menu"

        contentView.delegate = self

    }

}
extension MainViewController: MainViewDelegate {
    func openAlphabetButtonDidPressed() {
        let alphabetVM = AlphabetViewModel()
        let alphabetVC = AlphabetViewController(viewModel: alphabetVM)

        navigationController?.pushViewController(alphabetVC, animated: true)
    }
    
    func openTranslatorButtonDidPressed() {
        let translatorVM = TranslatorViewModel()
        let translatorVC = TranslatorViewController(viewModel: translatorVM)

        navigationController?.pushViewController(translatorVC, animated: true)
    }
    
    func openCameraButtonDidPressed() {
        let vm = CameraViewModel()
        let cameraVC = CameraViewController(viewModel: vm)

        navigationController?.pushViewController(cameraVC, animated: true)
    }

    func openGameButtonDidPressed() {
        let gameVM = VocabularyGamingViewModel()
        let gameVC = VocabularyGamingViewController(viewModel: gameVM)

        navigationController?.pushViewController(gameVC, animated: true)
    }


}
