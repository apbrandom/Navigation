//
//  LocalNotificationService.swift
//  Navigation
//
//  Created by Vadim Vinogradov on 04.08.2023.
//

import UserNotifications

class LocalNotificationService: NSObject, UNUserNotificationCenterDelegate  {
    
    
    static let shared = LocalNotificationService()
    private let notificationCenter = UNUserNotificationCenter.current()
    var userMessage = "LocalNSScheduleBodyText".localized
    
    private override init() {
        super.init()
        
        notificationCenter.delegate = self
    }
    
    internal func registerUpdatesCategory() {
        let viewUpdatesAction = UNNotificationAction(identifier: "viewUpdates", title: "View Updates", options: [])
        let updatesCategory = UNNotificationCategory(identifier: "updates", actions: [viewUpdatesAction], intentIdentifiers: [], options: [])
        notificationCenter.setNotificationCategories([updatesCategory])
    }
    
    internal func scheduleNotification() {
        let content = UNMutableNotificationContent()
        let titleText = "LocalNSScheduleTitleText".localized
        let bodyText = userMessage
        content.title = titleText
        content.body = bodyText
        content.sound = .default
        content.categoryIdentifier = "updates"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error sheduling notification: \(error)")
            }
        }
    }
    
    internal func registerForLatestUpdatesIfPossible() {
        registerUpdatesCategory()
        
        //Checking whether authorization has already been granted
        let defaults = UserDefaults.standard
        let wasPermissionGranted = defaults.bool(forKey: "wasPermissionGranted")
        
        if wasPermissionGranted {
            scheduleNotification()
            return
        }
        
        notificationCenter.requestAuthorization(options: [.sound, .badge, .provisional]) { [weak self] granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error requesting authorization: \(error)")
                } else if granted {
                    print("Permission granted")
                    self?.scheduleNotification()
                    defaults.set(true, forKey: "wasPermissionGranted")
                } else {
                    print("Permission denied")
                }
            }
        }
    }
    
    //MARK: - Delegate methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "viewUpdates" {
            print("View updates action received")
        }
        completionHandler()
    }
}

