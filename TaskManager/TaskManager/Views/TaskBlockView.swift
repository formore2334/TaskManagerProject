//
//  TaskBlockView.swift
//  CoreDataTM
//
//  Created by ForMore on 22/06/2023.
//

import SwiftUI

struct TaskBlockView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var taskManagerListVM: TaskManagerListViewModel
    @State private var isPresented = false
    
    var priority: TaskPriority
    
    @State private var selectedTask: TaskManagerViewModel?
    
    init(vm: TaskManagerListViewModel, priority: TaskPriority) {
        self.taskManagerListVM = vm
        self.priority = priority
    }
    
    func changeSelectedTask(task: TaskManagerViewModel) {
        selectedTask = task
    }
    
    private var hasTasks: Bool {
        return !taskManagerListVM.tasks.filter { $0.priority == priority.rawValue && !$0.isDone }.isEmpty
    }
    
    
    var body: some View {
        VStack {
            if hasTasks {
                Section(header: HStack {
                    Image(systemName: priority.iconName)
                        .foregroundColor(priority.colorName)
                    Text(priority.displayName)
                }) {
                    ForEach(taskManagerListVM.tasks.filter { $0.priority == priority.rawValue && !$0.isDone}) { task in
                        NavigationLink(destination: TaskEditorScreen(vm: TaskEditorViewModel(context: viewContext, task: task))) {
                            VStack(alignment: .leading) {
                                Text(task.headline)
                                    .font(.headline)
                                Text(task.descript)
                                    .font(.subheadline)
                                if let daysLeft = task.daysLeft {
                                    Text("\(daysLeft) days left")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 5))
                                }
                            }
                        }
                        .contextMenu {
                            VStack {
                                NavigationLink(destination: TaskEditorScreen(vm: TaskEditorViewModel(context: viewContext, task: task))) {
                                    Text("Edit")
                                    Image(systemName: "square.and.pencil")
                                }
                            }

                        }
                    }
                    .navigationTitle("Tasks")
                    
                }
            }
        }
    
        
    }
}

struct TaskBlockView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        TaskBlockView(vm: TaskManagerListViewModel(context: viewContext), priority: .high)
    }
}
