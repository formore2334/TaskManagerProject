//
//  ContextMenu.swift
//  CoreDataTM
//
//  Created by ForMore on 23/06/2023.
//

import SwiftUI

//struct ContextMenu: View {
//
//    @Environment(\.managedObjectContext) var viewContext
//    @ObservedObject var taskManagerListVM: TaskManagerListViewModel
//    @State private var isPresented = false
//
//    var priority: TaskPriority
//
//    init(vm: TaskManagerListViewModel, priority: TaskPriority) {
//        self.taskManagerListVM = vm
//        self.priority = priority
//    }
//
//    var body: some View {
//        VStack {
//            NavigationLink(destination: TaskEditorScreen(vm: TaskEditorViewModel(context: viewContext))) {
//                Text("Edit")
//                Image(systemName: "square.and.pencil")
//            }
//        }
//            Divider()
//
//            ForEach(TaskPriority.allCases, id: \.self) { priority in
//                Button(action: {
//                    if let index = taskManagerListVM.tasks.firstIndex(where: { $0.id == task.id }) {
//                        taskManagerListVM.tasks[index].priority = priority.rawValue
//                    }
//                    isPresented = false
//                }) {
//                    HStack {
//                        Text(priority.displayMenuText)
//                        Spacer()
////                        if task.priority == priority.rawValue {
////                            Image(systemName: "checkmark")
////                        }
//                    }
//                }
//            }
//
//            Divider()
//            Button(action: {
//                if let index = taskManagerListVM.tasks.firstIndex(where: { $0.id == task.id }) {
//                    taskManagerListVM.tasks[index].isDone.toggle()
//                }
//            }) {
//                Text("Mark as done")
//                Image(systemName: "checkmark.seal")
//            }
//
//            Divider()
//            Button(action: {
//                taskManagerListVM.tasks.removeAll() { $0.id == task.id }
//                print("delete")
//            }) {
//                Text("Delete")
//                Image(systemName: "trash")
//            }
//        }
//    }
//}
//
//struct ContextMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
//        ContextMenu(vm: TaskManagerListViewModel(context: viewContext), priority: .high)
//    }
//}
