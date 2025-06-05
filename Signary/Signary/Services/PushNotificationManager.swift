import UIKit

class PushNotificationManager: NSObject {

    private let notificationCenter = UNUserNotificationCenter.current()

    override init() {
        super.init()

        notificationCenter.delegate = self
    }

    func registerForNotifications() async throws {
        try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
    }

    func getNotificationSetting() async -> UNNotificationSettings {
        await notificationCenter.notificationSettings()
    }

}
extension PushNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }

//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        response.notification.request.content.userInfo["aps"] as? [String: Any]
//    }
}
extension PushNotificationManager {
    func getLocalNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Signary"
        notificationContent.body = "Let`s go to learn Sign Language"
        notificationContent.sound = .defaultRingtone

        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 00

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let notificationRequest = UNNotificationRequest(identifier: "daily_notification", content: notificationContent, trigger: trigger)

        notificationCenter.add(notificationRequest) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled.")
            }
        }

    }
}
