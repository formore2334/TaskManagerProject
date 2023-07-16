//
//  TaskManagerViewModel.swift
//  CoreDataTM
//
//  Created by ForMore on 21/06/2023.
//

import Foundation
import CoreData
import SwiftUI

class TaskManagerListViewModel: NSObject, ObservableObject {
    
    @Published var tasks = [TaskManagerViewModel]()
    private var fetchedResultController: NSFetchedResultsController<Task>
    
    @Published var selectedTaskId: NSManagedObjectID?
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: Task.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
            guard let tasks = fetchedResultController.fetchedObjects else {
                return
            }
            
            self.tasks = tasks.map(TaskManagerViewModel.init)
        } catch {
            print(error)
        }
    }
    
    
    func deleteTask(taskId: NSManagedObjectID) {
        do {
            guard let task = try context.existingObject(with: taskId) as? Task else {
                return
            }
            try task.delete()
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteAllCompletedTasks() {
        let completedTaskIds = tasks.filter { $0.isDone }.map { $0.id }
        for taskId in completedTaskIds {
            do {
                guard let task = try context.existingObject(with: taskId) as? Task else {
                    continue
                }
                context.delete(task)
            } catch {
                print(error)
            }
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    func markAsDone(taskId: NSManagedObjectID) {
        do {
            guard let task = try context.existingObject(with: taskId) as? Task else {
                return
            }
            
            task.isDone = true
            try context.save()
            
        } catch {
            print(error)
        }
    }

    func changePriority(taskId: NSManagedObjectID, newPriority: TaskPriority) {
        do {
            guard let task = try context.existingObject(with: taskId) as? Task else {
                return
            }
            task.priority = newPriority.rawValue
            try context.save()
        } catch {
            print(error)
        }
    }
}


extension TaskManagerListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let tasks = controller.fetchedObjects as? [Task] else {
            return
        }
        
        self.tasks = tasks.map(TaskManagerViewModel.init)
    }
}


struct TaskManagerViewModel: Identifiable {
    
    private var task: Task
    
    
    init(task: Task) {
        self.task = task
    }
    
    var id:NSManagedObjectID {
        task.objectID
    }
    
    var headline: String {
        task.headline ?? ""
    }
    
    var descript: String {
        task.descript ?? ""
    }
    
    var priority: String {
        task.priority ?? ""
    }
    
    var isDone: Bool {
        task.isDone
    }
    
    var startDate: Date {
        task.startDate ?? Date()
    }
    
    var finishDate: Date {
        task.finishDate ?? Date()
    }

    var timeLeft: String {
        guard Calendar.current.dateComponents([.day, .hour, .minute], from: startDate, to: finishDate).minute != 0  else { return "" }
        
        let components = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: finishDate)
        
        if let days = components.day, days > 1 {
            return "\(days) days left"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) hours left"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) minutes left"
        } else {
            return "Time out"
        }
    }

}



enum TaskPriority: String, CaseIterable {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
    case note = "Note"
    
    var iconName: String {
        switch self {
        case .high:
            return "flame.fill"
        case .medium:
            return "clock.fill"
        case .low:
            return "clock.badge.checkmark.fill"
        case .note:
            return "archivebox.fill"
        }
    }
    
    var colorName: Color {
        switch self {
        case .high:
            return Color.red
        case .medium:
            return Color.yellow
        case .low:
            return Color.green
        default:
            return Color.pink
        }
    }
    
    var displayName: String {
        switch self {
        case .high:
            return "HIGH PRIORITY"
        case .medium:
            return "WORTH DOING"
        case .low:
            return "YOU STILL HAVE TIME"
        default:
            return ""
        }
    }
}


//var timeLeft: String {
//    guard let finishDate = task.finishDate else { return "" }
//
//
//    if finishDate < Date() {
//        return "Time out"
//    }
//
//    let components = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: finishDate)
//
//    if let days = components.day, days > 1 {
//        return "\(days) days left"
//    } else if let hours = components.hour, hours > 0 {
//        return "\(hours) hours left"
//    } else if let minutes = components.minute, minutes > 0 {
//        return "\(minutes) minutes left"
//    } else {
//        return ""
//    }
//}



//var timeLeft: String {
//    guard let finishDate = task.finishDate else { return "" }
//
//    if finishDate < Date() {
//        return "Time out"
//    }
//
//    let components = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: finishDate)
//
//    var timeLeftString = ""
//
//    if let days = components.day, days > 0 {
//        timeLeftString += "\(days) day\(days > 1 ? "s" : "") "
//    }
//
//    if let hours = components.hour, hours > 0 {
//        timeLeftString += "\(hours) hour\(hours > 1 ? "s" : "") "
//    }
//
//    if let minutes = components.minute, minutes > 0 {
//        timeLeftString += "\(minutes) minute\(minutes > 1 ? "s" : "")"
//    }
//
//    return timeLeftString
//}




//normall
//var timeLeft: String {
//    guard let finishDate = task.finishDate else { return "" }
//
//    let components = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: finishDate)
//
//    if let days = components.day, days > 1 {
//        return "\(days) days left"
//    } else if let hours = components.hour, hours > 0 {
//        return "\(hours) hours left"
//    } else if let minutes = components.minute, minutes > 0 {
//        return "\(minutes) minutes left"
//    } else {
//        return "Time out"
//    }
//}
