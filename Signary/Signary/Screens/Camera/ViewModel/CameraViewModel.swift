
import UIKit
import Vision
import Combine

class CameraViewModel {

    @Published var willBeShowedCommand: RemoteCommand?

    let bufferSize = 3

    var commandBuffer = [RemoteCommand]()

    var currentCommand: RemoteCommand = .none {
        didSet {
            commandBuffer.append(currentCommand)
            if commandBuffer.count == bufferSize {
                if commandBuffer.filter({$0 == currentCommand}).count == bufferSize {
                    willBeShowedCommand = currentCommand
//                    setupCommandCaption(command: currentCommand)
                }
                commandBuffer.removeAll()
            }
        }
    }

    func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation

        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:
            exifOrientation = .down
        case UIDeviceOrientation.portrait:
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }

    func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results else { print("no results"); return }

        let classifications = observations
            .compactMap({$0 as? VNClassificationObservation})
            .filter({$0.confidence > 0.3})
            .map({$0.identifier})

        print(classifications)

        switch classifications.first {
        case "0":
            currentCommand = .zero
        case "1":
            currentCommand = .one
        case "2":
            currentCommand = .two
        case "3":
            currentCommand = .three
        case "4":
            currentCommand = .four
        case "5":
            currentCommand = .five
        case "6":
            currentCommand = .six
        case "7":
            currentCommand = .seven
        case "8":
            currentCommand = .eight
        case "9":
            currentCommand = .nine
        default:
            currentCommand = .none
        }

    }

    func getCommand(_ command: RemoteCommand) -> String {
        switch command {
        case .none:
            return "Nothing"
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        }
    }

}
