//
//  NotificationManager.swift
//  2023-05-11-NotificationTest
//
//  Created by Leigh Jin on 5/11/23.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        //request authorization
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: options) { success, error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("authorization sucess")
                }
            }
    }
    
    func scheduleNotification() {
        //1. create notification content
        let content = UNMutableNotificationContent()
        content.title = "App Showcase on 5/23"
        content.subtitle = "Demo Your Skills"
        content.body = """
            Time: 5/23 @ 12:30pm
            Location: SFSU Library 260
        """
        content.sound = .default
        
        //2. Create notification trigger
        //2.1 trigger by time delay in seconds
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //2.2 trigger by calendar
        //configure the date and time to trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 13
//        dateComponents.minute = 23
//        dateComponents.weekday = 5 //every thursday
//
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //2.3 location based trigger
        let sfsuCoordinates = CLLocationCoordinate2D(latitude: 37.720663784, longitude: -122.474498102)
        let region = CLCircularRegion(center: sfsuCoordinates, radius: 100, identifier: UUID().uuidString)
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        //3. request the notification by trigger
        let request = UNNotificationRequest(identifier: "SFSU App Showcase Notification", content: content, trigger: trigger)
    
        //add the request to the notification center
        UNUserNotificationCenter.current().add(request)
    }
    
}
