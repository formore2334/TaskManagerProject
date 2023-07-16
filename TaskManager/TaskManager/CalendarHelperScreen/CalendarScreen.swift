//
//  CalendarScreen.swift
//  CoreDataTM
//
//  Created by ForMore on 27/06/2023.
//

import SwiftUI


struct CalendarScreen: View {
    
    @ObservedObject var vm: TaskManagerListViewModel
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                CustomDatePicker(currentDate: $currentDate, vm: vm)
            }
        }
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        CalendarScreen(vm: TaskManagerListViewModel(context: viewContext))
    }
}
