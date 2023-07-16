//
//  TabViewController.swift
//  CoreDataTM
//
//  Created by ForMore on 22/06/2023.
//

import SwiftUI

struct TabViewController: View {
    
    @State private var selectedView = 2
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject private var taskManagerVM: TaskManagerListViewModel
    @ObservedObject var settingsManager: SettingsManager
    
    init(vm: TaskManagerListViewModel, settingsManager: SettingsManager) {
        self.taskManagerVM = vm
        self.settingsManager = settingsManager
    }
    
    var body: some View {
        TabView(selection: $selectedView) {
            
            CalendarScreen(vm: taskManagerVM)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }.tag(1)
            
            ContentView(vm: taskManagerVM, settingsManager: settingsManager)
                .tabItem {
                    Image(systemName: "clock")
                    Text("In the progress")
                }.tag(2)
            
            NotesScreen(vm: taskManagerVM)
                .tabItem {
                    Image(systemName: "tray.full")
                    Text("Notes")
                }.tag(3)
            
            CompletedTasksScreen(vm: taskManagerVM)
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Completed")
                }.tag(4)
            
            SettingsScreen(settingsManager: settingsManager)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(5)
            
        }
    }
}

struct TabViewController_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        TabViewController(vm: TaskManagerListViewModel(context: viewContext), settingsManager: SettingsManager())
    }
}
