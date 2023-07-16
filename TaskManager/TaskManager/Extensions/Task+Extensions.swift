//
//  TM+Extensions.swift
//  CoreDataTM
//
//  Created by ForMore on 21/06/2023.
//

import Foundation
import CoreData

extension Task: BaseModel {
    
    static var all: NSFetchRequest<Task> {
        let request = Task.fetchRequest()
        request.sortDescriptors = []
        return request
    }
}
