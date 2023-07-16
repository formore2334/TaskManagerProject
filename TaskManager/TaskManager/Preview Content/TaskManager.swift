//
//  CoreDataTMApp.swift
//  CoreDataTM
//
//  Created by ForMore on 21/06/2023.
//

import SwiftUI
import UserNotifications

@main
struct TaskManager: App {
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
            TabViewController(vm: TaskManagerListViewModel(context: viewContext),settingsManager: SettingsManager())
                .environment(\.managedObjectContext, viewContext)
            
        }
    }
}


