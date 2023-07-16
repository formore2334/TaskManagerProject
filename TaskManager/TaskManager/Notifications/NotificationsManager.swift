//
//  NotificationsManager.swift
//  CoreDataTM
//
//  Created by ForMore on 11/07/2023.
//

import Foundation
import Dispatch
import UserNotifications

class NotificationManager {

    var accordingPriority: AccordingPriority
    var accordingTime: AccordingTime
    
    init(accordingPriority: AccordingPriority, accordingTime: AccordingTime) {
        self.accordingPriority = accordingPriority
        self.accordingTime = accordingTime
    }
    
    func scheduleNotification(for task: Task) {
        DispatchQueue.global().async {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    print("Notification permission granted")
                } else {
                    print("Notification permission denied")
                }
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Task Reminder"
            content.body = "Your task \(task.headline ?? "") with priority \(task.priority ?? "") due soon!"
            content.sound = UNNotificationSound.default
            
            
            var timeInterval: TimeInterval = 0
            
            switch self.accordingTime {
            case .thirtyMinutes:
                timeInterval = 30 * 60
            case .oneHour:
                timeInterval = 60 * 60
            case .twoHours:
                timeInterval = 2 * 60 * 60
            case .fourHours:
                timeInterval = 4 * 60 * 60
            case .eightHours:
                timeInterval = 8 * 60 * 60
            case .oneDay:
                timeInterval = 24 * 60 * 60
            case .twoDays:
                timeInterval = 2 * 24 * 60 * 60
            case .oneWeek:
                timeInterval = 7 * 24 * 60 * 60
            case .oneMonth:
                timeInterval = 30 * 24 * 60 * 60
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let request = UNNotificationRequest(identifier: ("\(task.id)"), content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Failed to schedule notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully")
                }
            }
        }
    }
    
}
enum AccordingPriority: String, CaseIterable {
    
    case high = "High"
    case medium = "Medium"
    case low = "Low"
  
}

enum AccordingTime: String, CaseIterable {
    
    case thirtyMinutes = "30 minutes"
    case oneHour = "1 hour"
    case twoHours = "2 hours"
    case fourHours = "4 hours"
    case eightHours = "8 hours"
    case oneDay = "1 day"
    case twoDays = "2 days"
    case oneWeek = "1 week"
    case oneMonth = "1 month"
    
}





