//
//  TaskEditorViewModel.swift
//  CoreDataTM
//
//  Created by ForMore on 22/06/2023.
//

import Foundation
import CoreData



class TaskEditorViewModel: ObservableObject {
    
    @Published var task: TaskManagerViewModel?
    
    @Published var headline: String
    @Published var descript: String
    @Published var isDone: Bool
    @Published var priority: String
    @Published var startDate: Date
    @Published var finishDate: Date
    @Published var timeLeft: String
    
    var context: NSManagedObjectContext
    var notificationManager = NotificationManager(accordingPriority: .high, accordingTime: .oneHour)
    init(context: NSManagedObjectContext, task: TaskManagerViewModel?) {
        self.context = context
        self.task = task
        
        self.headline = task?.headline ?? ""
        self.descript = task?.descript ?? ""
        self.isDone = task?.isDone ?? false
        self.priority = task?.priority ?? "High"
        self.startDate = task?.startDate ?? Date()
        self.finishDate = task?.finishDate ?? Date()
        self.timeLeft = task?.timeLeft ?? ""
    }
    
    func createNewTask() {
        guard !headline.isEmpty || !descript.isEmpty else { return }
        let newTask = Task(context: context)
                newTask.headline = headline
                newTask.descript = descript
                newTask.isDone = isDone
                newTask.priority = priority
                newTask.startDate = startDate
                newTask.finishDate = finishDate
                newTask.timeLeft = timeLeft
        
        notificationManager.scheduleNotification(for: newTask)
                do {
                    try context.save()
                    task = TaskManagerViewModel(task: newTask)
                } catch {
                    print(error)
                }
    }
    
    func save() {
        guard !headline.isEmpty || !descript.isEmpty else { return }
        guard let taskId = task?.id else { return }
        do {
            let taskToUpdate = try context.existingObject(with: taskId) as! Task
            taskToUpdate.headline = headline
            taskToUpdate.descript = descript
            taskToUpdate.priority = priority
            taskToUpdate.isDone = isDone
            taskToUpdate.startDate = startDate
            taskToUpdate.finishDate = finishDate
            taskToUpdate.timeLeft = timeLeft
            
                notificationManager.scheduleNotification(for: taskToUpdate)
            try context.save()
        } catch {
            print(error)
        }
    }
}





//class TaskEditorViewModel: ObservableObject {
//
//    @Published var task: TaskManagerViewModel
//
//    @Published var headline: String = ""
//    @Published var descript: String = ""
//    @Published var isDone: Bool = false
//    @Published var priority: String = ""
//    @Published var startDate: Date = Date()
//    @Published var finishDate: Date = Date()
//    @Published var daysLeft: Int16 = 0
//
//    var context: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext, task: TaskManagerViewModel) {
//        self.context = context
//        self.task = task
//    }
//
//    func save() {
//        do {
//
//            let task = Task(context: context)
//            task.headline = headline
//            task.descript = descript
//            task.priority = priority
//            task.isDone = isDone
//            task.startDate = startDate
//            task.finishDate = finishDate
//            task.daysLeft = daysLeft
//            try task.save()
//
//        } catch {
//            print(error)
//        }
//
//    }
//
//
//}
