import UIKit
import Firebase
import UserNotifications

extension Extension.FirebaseMessaging {
    static let app = App.getApp()

    static func registerForNotifications(_ application: UIApplication) {
        let appDelegate = application.delegate as! AppDelegate

        Messaging.messaging().delegate = appDelegate
        FirebaseApp.configure()
    }

    fileprivate static func pushToken() {
        let token = Messaging.messaging().fcmToken
        app.client.pushEvent("FirebaseMessaging/token", args: [token])
    }

    fileprivate static func registerNotifications() {
        let application = UIApplication.shared
        let appDelegate = application.delegate as! AppDelegate

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = appDelegate

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        pushToken()
    }

    fileprivate static func onMessage(_ userInfo: [AnyHashable: Any]) {
        var data = [String: String?]()
        for (key, value) in userInfo {
            let keyStr = key as? String
            guard keyStr != nil else { continue }
            if !keyStr!.starts(with: "google.") && !keyStr!.starts(with: "gcm.") && keyStr != "aps" {
                data[keyStr!] = value as? String
            }
        }
        let dataJsonRow = try? JSONSerialization.data(withJSONObject: data)
        let dataJson = dataJsonRow.map { it in String(data: it, encoding: .ascii) } ?? nil

        app.client.pushEvent("FirebaseMessaging/messageReceived", args: [dataJson])
    }

    static func register() {
        app.client.addCustomFunction("FirebaseMessaging/register") { _ in
            registerNotifications()
        }

        app.client.addCustomFunction("FirebaseMessaging/getToken") { _ in
            pushToken()
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        Extension.FirebaseMessaging.onMessage(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Extension.FirebaseMessaging.onMessage(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        Extension.FirebaseMessaging.pushToken()
    }
}
