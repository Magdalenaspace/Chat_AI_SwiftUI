//
//  CoreDataManager.swift
//  ChatAI
//
//  Created by Magdalena Samuel on 6/29/23.
//

import Foundation
import CoreData

class CoraDataManager {
    
    let presistentContainer: NSPersistentContainer
    static let shared = CoraDataManager()
    
    private init() {
        presistentContainer = NSPersistentContainer(name: "ChatHistoryModel")
        presistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Stoe Failed \(error.localizedDescription)")
            }
        }
    }
}

