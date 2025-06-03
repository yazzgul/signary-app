
import UIKit
import AVFoundation
import Vision

class CameraView: UIView {

    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.text = "Show any gesture"
        label.numberOfLines = 1
        label.font = .titleFont
        label.textColor = .darkPurple()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var previewLayer: AVCaptureVideoPreviewLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightBlue()
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }

}
extension CameraView {
    private func configureView() {
        addSubview(wordLabel)
        
        NSLayoutConstraint.activate([
            
            wordLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            wordLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            wordLabel.widthAnchor.constraint(equalToConstant: 400),
            wordLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    public func configureView(with word: String) {
        wordLabel.text = word
    }
    public func setPreviewLayer(_ layer: AVCaptureVideoPreviewLayer) {
        self.previewLayer = layer
        layer.videoGravity = .resizeAspectFill
        layer.frame = bounds
        layer.zPosition = -1 // чтобы быть под метками/элементами UI
        self.layer.insertSublayer(layer, at: 0)
    }
}
