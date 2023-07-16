//
//  TaskContextMenu.swift
//  CoreDataTM
//
//  Created by ForMore on 26/06/2023.
//

import SwiftUI

struct TaskContextMenu: View {
    
    let task: TaskManagerViewModel
    let editAction: ()->()
    let markAsDoneAction: ()->()
    let changePriorityAction: (TaskPriority)->()
    let deleteAction: ()->()
    
    @State private var selectedPriority: TaskPriority
    
    init(task: TaskManagerViewModel,
         editAction: @escaping () -> (),
         markAsDoneAction: @escaping () -> (),
         changePriorityAction: @escaping (TaskPriority) -> (),
         deleteAction: @escaping () -> ()) {
        self.task = task
        self.editAction = editAction
        self.markAsDoneAction = markAsDoneAction
        self.changePriorityAction = changePriorityAction
        self.deleteAction = deleteAction
        self._selectedPriority = State(initialValue: TaskPriority(rawValue: task.priority) ?? .high)
    }
    var body: some View {
        VStack {
            
            Button(action: editAction) {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(action: markAsDoneAction) {
                Label("Mark as Done", systemImage: "checkmark.circle.fill")
            }
            
            Picker("Priority", selection: $selectedPriority) {
                
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Label(priority.rawValue, systemImage: priority.iconName)
                        .foregroundColor(priority.colorName)
                }
                
            }.onChange(of: selectedPriority) { newValue in
                changePriorityAction(newValue)
            }
            
            Button(action: deleteAction) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

//struct TaskContextMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskContextMenu()
//    }
//}
