//
//  NoPriorityScreen.swift
//  CoreDataTM
//
//  Created by ForMore on 27/06/2023.
//

import SwiftUI


struct NotesScreen: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var taskManagerListVM: TaskManagerListViewModel
    @State private var isPresented = false
    
    
    init(vm: TaskManagerListViewModel) {
        self.taskManagerListVM = vm
    }
    
    private var noPriority: Bool {
        return !taskManagerListVM.tasks.filter { $0.priority == "Note" }.isEmpty
    }
    
    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            let task = taskManagerListVM.tasks.filter {$0.priority == "Note"}[index]
            taskManagerListVM.deleteTask(taskId: task.id)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if noPriority == true {
                    List {
                        ForEach(taskManagerListVM.tasks.filter { $0.priority == "Note" }) { task in
                            
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
                    .listStyle(PlainListStyle())
                }else{
                    Text("No tasks")
                }
            }
                .navigationBarTitle("Notes", displayMode: .inline)
        }
    }
}

//struct NoPriorityScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NoPriorityScreen()
//    }
//}
