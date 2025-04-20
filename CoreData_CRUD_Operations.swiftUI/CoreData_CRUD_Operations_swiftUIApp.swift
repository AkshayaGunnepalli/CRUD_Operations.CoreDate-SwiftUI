//
//  CoreData_CRUD_Operations_swiftUIApp.swift
//  CoreData_CRUD_Operations.swiftUI
//
//  Created by Akshaya Gunnepalli on 19/04/25.
//

import SwiftUI

@main
struct CoreData_CRUD_Operations_swiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
