//
//  ContentView.swift
//  CoreDataTM
//
//  Created by ForMore on 21/06/2023.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var vm: TaskManagerListViewModel
    @ObservedObject var settingsManager: SettingsManager
    
    @State private var showTaskEditor = false
    @State private var isPriorityMenuShowing = false

    var filteredPriorities: [TaskPriority] {
        return TaskPriority.allCases.filter { $0 != .note }
       }
   

    var body: some View {
        NavigationView {
            
            VStack {
                
                List {
                    ForEach(filteredPriorities, id: \.self) { priority in
                        let tasks = vm.tasks.filterBy(priority: priority)
                        if !tasks.isEmpty {
                            Section(header: HStack {
                                Image(systemName: priority.iconName)
                                    .foregroundColor(settingsManager.selectedStyle == .brightStyle ? priority.colorName : Color(.systemBlue))
                                Text(settingsManager.selectedStyle == .brightStyle ? priority.displayName : priority.rawValue)
                            }) {
                                ForEach(tasks) { task in
                                    NavigationLink(destination: TaskEditorScreen(vm: TaskEditorViewModel(context: vm.context, task: task))) {
                                        VStack(alignment: .leading) {
                                            Text(task.headline)
                                                .font(.headline)
                                                .lineLimit(1)
                                            Text(task.descript)
                                                .font(.body)
                                                .lineLimit(1)
                                            if let timeLeft = task.timeLeft {
                                                if timeLeft != "" {
                                                    Text(timeLeft)
                                                        .font(.caption)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                        }
                                    }
                                    .contextMenu {
                                        TaskContextMenu(
                                            task: task,
                                            editAction: {
                                                showTaskEditor = true
                                            },
                                            markAsDoneAction: {
                                                vm.markAsDone(taskId: task.id)
                                            },
                                            changePriorityAction: { priority in
                                                vm.changePriority(taskId: task.id, newPriority: priority)
                                            },
                                            deleteAction: {
                                                vm.deleteTask(taskId: task.id)
                                            }
                                        )
                                    }
                                    .sheet(isPresented: $showTaskEditor) {
                                        TaskEditorScreen(vm: TaskEditorViewModel(context: vm.context, task: task))
                                    }
                                }
                            }
                        }
                    }
                    .modifier(IconSizeModifier(settingsManager: settingsManager))
                }
                .modifier(ListStyleModifier(settingsManager: settingsManager))
                .navigationBarTitle("Tasks List")
                .navigationBarItems(trailing: NavigationLink(destination: TaskEditorScreen(vm: TaskEditorViewModel(context: vm.context, task: nil))
                                                             , label: {
                    Image(systemName: "plus")
                }))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        ContentView(vm: TaskManagerListViewModel(context: viewContext), settingsManager: SettingsManager())
    }
}
