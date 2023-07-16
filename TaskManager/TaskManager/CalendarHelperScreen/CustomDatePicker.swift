//
//  CustomDatePicker.swift
//  CoreDataTM
//
//  Created by ForMore on 27/06/2023.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @ObservedObject var vm: TaskManagerListViewModel
    @ObservedObject var settingsManager = SettingsManager()
    @State private var currentMonth: Int = 0
    @State private var isPresented = false
    
    var settingsColor: Color {
        if settingsManager.selectedStyle == .brightStyle {
            return Color(.systemPink)
        } else {
            return Color(.systemBlue)
        }
    }
    
    var body: some View {
        VStack(spacing: 35) {
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }

            }
            .padding(.horizontal)
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                        
                            Capsule()
                                .fill(settingsColor.opacity(0.8))
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack(spacing: 15) {
                
                Text("Tasks")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                if let task = vm.tasks.first(where: { task in
                    return isSameDay(date1: task.finishDate, date2: currentDate)
                }) {
                    ForEach([task]) { task in
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(task.headline)
                                    .font(.title2.bold())
                                    .lineLimit(1)
                                Text(task.descript)
                                    .lineLimit(1)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.systemGray))
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Color(settingsManager.selectedStyle == .brightStyle ? .systemPurple : .systemBlue)
                                .opacity(0.5)
                                .cornerRadius(10)
                        )
                        .onTapGesture {
                            isPresented = true
                        }
                        .sheet(isPresented: $isPresented) {
                            TaskEditorScreen(vm: TaskEditorViewModel(context: vm.context, task: task))
                        }
                    }
                }
                else {
                    
                    Text("No Task Found")
                }
            }
            .padding()
        
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        
        VStack {
            if value.day != -1 {
                
                if let task = vm.tasks.first(where: { task in
                    
                    return isSameDay(date1: task.finishDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.finishDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.finishDate, date2: currentDate) ? .white : settingsColor.opacity(0.8))
                        .frame(width: 8, height: 8)
                }
                else {
                    
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    
    func extraDate() -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
       let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}


extension Date{
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
            
        }
    }
}
struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = CoreDataManager.shared.persistentStoreContainer.viewContext
        CalendarScreen(vm: TaskManagerListViewModel(context: viewContext))
    }
}

