//
//  desafioAIDApp.swift
//  desafioAID
//
//  Created by Matheus Azevedo on 25/06/21.
//

import SwiftUI

@main
struct desafioAIDApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
