
import UIKit
import AVFoundation
import Vision
import Combine

class CameraViewController: UIViewController {

    private var contentView: CameraView = .init()
    private let viewModel: CameraViewModel

    private var cancellables = Set<AnyCancellable>()

    //    Camera properties
    var captureSession = AVCaptureSession()
    var captureDevice: AVCaptureDevice!
    var devicePosition: AVCaptureDevice.Position = .front

    //    Vision
    var requests = [VNRequest]()
    
    init(viewModel: CameraViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true

        prepareCamera()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = contentView

        navigationItem.title = "Camera"

        setupVision()

        checkNewCommandCaption()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopCameraSession()

        self.tabBarController?.tabBar.isHidden = false

    }

}
extension CameraViewController {

    func setupCommandCaption(command: RemoteCommand) {
        contentView.configureView(with: viewModel.getCommand(command))
    }
    func checkNewCommandCaption() {
        viewModel.$willBeShowedCommand
            .receive(on: DispatchQueue.main)
            .sink { [weak self] command in
                if let command = command {
                    self?.setupCommandCaption(command: command)
                }
            }
            .store(in: &cancellables)
    }
}

extension CameraViewController {

    func stopCameraSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
        for input in captureSession.inputs {
            captureSession.removeInput(input)
        }

        for output in captureSession.outputs {
            captureSession.removeOutput(output)
        }

        contentView.previewLayer?.removeFromSuperlayer()
        contentView.previewLayer = nil

        requests.removeAll()

        print("Полностью остановлена камера и Vision")
    }

    func setupVision() {
        do {
            let config = MLModelConfiguration()
//            конфигурация мл модели
            let handModel = try HandClassifier(configuration: config)
            let visionModel = try VNCoreMLModel(for: handModel.model)

            let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: viewModel.handleClassification)
            classificationRequest.imageCropAndScaleOption = .scaleFit

            requests = [classificationRequest]
        } catch {
            fatalError("Не удалось загрузить модель или создать VNCoreMLModel: \(error)")
        }
    }

}
extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func prepareCamera () {
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices

        captureDevice = availableDevices.first
        beginSession()
    }

    func beginSession() {
        if captureDevice == nil {
            AlertManager.showNotFoundCameraAlert(on: self)
            return
        }
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print("Couldn`t create video device input")
            AlertManager.showCannotCameraAccessAlert(on: self)
            return
        }
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .vga640x480

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
        dataOutput.alwaysDiscardsLateVideoFrames = true

        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        captureSession.commitConfiguration()

        DispatchQueue.main.async {
            let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.contentView.setPreviewLayer(previewLayer)
        }

        let queue = DispatchQueue(label: "captureQueue")
        dataOutput.setSampleBufferDelegate(self, queue: queue)

        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            print("СaptureSession started")

        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let exifOrientation = viewModel.exifOrientationFromDeviceOrientation()
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])

        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print("Error in captureOutput: \(error.localizedDescription)")
        }
    }

}
