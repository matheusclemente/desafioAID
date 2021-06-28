//
//  Persistence.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 27/06/21.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "desafioAID")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error)")
            }
        }
    }
}
