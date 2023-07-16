//
//  CompletedTasksScreen.swift
//  CoreDataTM
//
//  Created by ForMore on 22/06/2023.
//

import SwiftUI

struct CompletedTasksScreen: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var taskManagerListVM: TaskManagerListViewModel
    @State private var isPresented = false
    
    
    init(vm: TaskManagerListViewModel) {
        self.taskManagerListVM = vm
    }
    
    private var hasDone: Bool {
        return !taskManagerListVM.tasks.filter { $0.isDone }.isEmpty
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = taskManagerListVM.tasks.filter { $0.isDone }[index]
            taskManagerListVM.deleteTask(taskId: task.id)
        }
    }
    
    var body: some View {
        NavigationView {
            
            if hasDone == true {
                List {
                    ForEach(taskManagerListVM.tasks.filter { $0.isDone}) { task in
                        
                        NavigationLink(destination: TaskEditorScreen(vm: TaskEditorViewModel(context: viewContext, task: task))) {
                            VStack(alignment: .leading) {
                                Text(task.headline)
                                    .font(.headline)
                                Text(task.descript)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationBarTitle("Completed Tasks")
                .navigationBarItems(trailing: Button(action: {
                    taskManagerListVM.deleteAllCompletedTasks()
                    
                }, label: {
                    Image(systemName: "trash")
                }))
            }else{
                Text("No tasks")
            }
            
        }
    }
}

struct CompletedTasksScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        CompletedTasksScreen(vm: TaskManagerListViewModel(context: viewContext))
    }
}
