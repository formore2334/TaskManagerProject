//
//  View+Extensions.swift
//  CoreDataTM
//
//  Created by ForMore on 24/06/2023.
//

import Foundation
import SwiftUI

extension Array where Element == TaskManagerViewModel {
    func filterBy(priority: TaskPriority) -> [TaskManagerViewModel] {
        self.filter {
            $0.priority == priority.rawValue && !$0.isDone
        }
    }
}



   


