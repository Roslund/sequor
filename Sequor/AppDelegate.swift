import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Migrates users to the new id userid system.
    if UserDefaults.standard.bool(forKey: "userIDMigration") == false {
      UserDefaults.standard.set(UIDevice.current.name, forKey: "userID")
      UserDefaults.standard.set(true, forKey: "userIDMigration")
    }

    // Notifications setup
    UNUserNotificationCenter.current().delegate = self
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound], completionHandler: {_, _ in })

    DispatchQueue.main.async {
      UIApplication.shared.registerForRemoteNotifications()
    }

    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after
    // application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

  // MARK: Notifications

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let token = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    print("Device Token: \(token)")
    // Add the token to the clipboard
    UIPasteboard.general.string = token
  }

  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print(error)
  }

  // This method will be called when app received push notifications in foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping
                              (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .badge, .sound])
  }
}
