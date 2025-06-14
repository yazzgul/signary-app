
import UIKit

class NavigationBarAppearanceConfiguration {

    static func applyGlobalAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkPurple()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.delicateBlue(),
            .font: UIFont.navigationBarFont
        ]

        let backAppearance = UIBarButtonItemAppearance()
        backAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backAppearance

        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
        navBar.compactAppearance = appearance
        navBar.tintColor = UIColor.lightBlue()

    }

    static func applyTitleView(to navigationItem: UINavigationItem, title: String = "Signary") {

        let iconImageView = UIImageView(image: UIImage(systemName: "hand.raised"))
        iconImageView.tintColor = UIColor.lightBlue()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let customTitleLabel = UILabel()
        customTitleLabel.text = title
        customTitleLabel.textColor = UIColor.lightBlue()
        customTitleLabel.font = .navigationBarFont

        let stackView = UIStackView(arrangedSubviews: [iconImageView, customTitleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center

        navigationItem.titleView = stackView
    }

    static func applyOnlyTitleView(to navigationItem: UINavigationItem, title: String = "Signary") {
        let customTitleLabel = UILabel()
        customTitleLabel.text = title
        customTitleLabel.textColor = UIColor.lightBlue()
        customTitleLabel.font = .navigationBarFont
        customTitleLabel.textAlignment = .center

        navigationItem.titleView = customTitleLabel
    }

    static func applyTitleStartView(to navigationItem: UINavigationItem, title: String?) {

        let handIcons = ["hand.raised", "hand.tap", "hand.point.up.left", "hand.thumbsup", "hand.draw"]

        let handImageViews: [UIImageView] = handIcons.map { iconName in
            let imageView = UIImageView(image: UIImage(systemName: iconName))
            imageView.tintColor = UIColor.lightBlue()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false

            imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

            return imageView
        }

        let handsStackView = UIStackView(arrangedSubviews: handImageViews)
        handsStackView.axis = .horizontal
        handsStackView.spacing = 10
        handsStackView.alignment = .center
        handsStackView.distribution = .equalSpacing

        navigationItem.titleView = handsStackView
    }
}
