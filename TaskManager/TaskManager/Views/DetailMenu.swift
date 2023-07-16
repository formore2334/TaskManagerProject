//
//  DetailMenu.swift
//  CoreDataTM
//
//  Created by ForMore on 23/06/2023.
//

import SwiftUI

struct DetailMenu: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: TaskEditorViewModel
    @State private var isExpanded = false
    
    private var isNew: Bool {
        vm.task == nil
    }
    
    init(vm: TaskEditorViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            DisclosureGroup("Details", isExpanded: $isExpanded) {
                DatePicker(selection: $vm.startDate, label: { Text("Start date") })
                    .padding(.top, 30)
                Divider()
                DatePicker(selection: $vm.finishDate, label: { Text("Due date") })
                Divider()
                
                HStack {
                    Text("Priority")
                    Spacer()
                    Picker(selection: $vm.priority, label: Text("Priority")) {
                            Text("High").tag("High")
                            Text("Medium").tag("Medium")
                            Text("Low").tag("Low")
                            Divider()
                            Text("Note").tag("Note")
                    }
                }
                Divider()
                HStack {
                    Text("Completed")
                    Spacer()
                    Toggle("", isOn: $vm.isDone)
                        .scaleEffect(0.8)
                }
                
                Button("Save") {
                    if self.isNew {
                        vm.createNewTask()
                    } else {
                        vm.save()
                    }
                    isExpanded = false
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(vm.headline.isEmpty || vm.descript.isEmpty)
            }
            .padding(20)
            .background(Color(.systemGray4))
            .cornerRadius(15)
            .onChange(of: isExpanded) { newValue in
                   if newValue {
                       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                   }
               }
        }
    }
}

//struct DetailMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
//        DetailMenu(vm: TaskEditorViewModel(context: viewContext))
//    }
//}
