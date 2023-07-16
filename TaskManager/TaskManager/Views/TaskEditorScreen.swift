//
//  TaskEditorScreen.swift
//  CoreDataTM
//
//  Created by ForMore on 22/06/2023.
//

import SwiftUI

struct TaskEditorScreen: View {
    
    @ObservedObject var vm: TaskEditorViewModel
    @State private var isHideKeyboard = false
    init(vm: TaskEditorViewModel) {
        self.vm = vm
    }
    
    var isNew: Bool {
        vm.task == nil
    }
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                VStack {
                    TextField("Header", text: $vm.headline)
                        .font(.headline)
                        .padding()
                }.cornerRadius(40)
                    .background(Color(.systemGray6))
                    .onTapGesture {
                        // Hide keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                VStack {
                    TextEditor(text: $vm.descript)
                        .font(.body)
                        .frame(maxHeight: .infinity)
                        .background(Color(.systemGray2))
                }
                
            }.background(Color(.systemBackground))
                .cornerRadius(15)
                .padding(10)
                .shadow(radius: 5)
                .onTapGesture {
                    // Hide keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            
            VStack {
                DetailMenu(vm: vm)
            }
            
        }
        .background(Color(.systemGray5))
        .navigationBarItems(trailing: Button(action: {
            //
        }, label: {
            Image(systemName: "gear")
                .foregroundColor(Color(.systemGray))
        }))
        .navigationBarTitle(vm.headline, displayMode: .inline)
        .onDisappear {
            vm.save()
        }
    }
}


//struct TaskEditorScreen_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
//
//        TaskEditorScreen(vm: TaskEditorViewModel(context: viewContext))
//    }
//}
