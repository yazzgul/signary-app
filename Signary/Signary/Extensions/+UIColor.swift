
import UIKit

extension UIColor {
//    почти белый
    static func lightBlue(alpha: Double = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(225) / 255.0,
            green: CGFloat(239) / 255.0,
            blue: CGFloat(240) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
//    нежно голубой
    static func delicateBlue(alpha: Double = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(182) / 255.0,
            green: CGFloat(213) / 255.0,
            blue: CGFloat(224) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    static func darkPurple(alpha: Double = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(86) / 255.0,
            green: CGFloat(82) / 255.0,
            blue: CGFloat(115) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    static func darkBlue(alpha: Double = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(101) / 255.0,
            green: CGFloat(122) / 255.0,
            blue: CGFloat(155) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
