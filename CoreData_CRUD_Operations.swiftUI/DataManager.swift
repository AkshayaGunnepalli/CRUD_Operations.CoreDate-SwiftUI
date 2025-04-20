//
//  DataManager.swift
//  CoreData_CRUD_Operations.swiftUI
//
//  Created by Akshaya Gunnepalli on 19/04/25.
//

import SwiftUI
import CoreData

/// Model used for creating/updating Item entities
struct DataModel {
    var name: String?
    var id: String?
}

/// Centralized class for handling Core Data CRUD operations
final class DataManager: ObservableObject {
    
    // MARK: - Properties
    static let shared = DataManager()
    private let viewContext = PersistenceController.shared.container.viewContext
    
    // MARK: - Initializer
    private init() {}

    // MARK: - Create
    func addItem(model: DataModel) {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.name = model.name
            newItem.identity = model.id
            saveContext()
        }
    }

    // MARK: - Read
    func getItems() -> [Item] {
        do {
            return try viewContext.fetch(Item.fetchRequest())
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }

    // MARK: - Update
    func updateItem(_ item: Item, with model: DataModel) {
        withAnimation {
            item.name = model.name
            item.identity = model.id
            item.timestamp = Date()
            saveContext()
        }
    }

    // MARK: - Delete
    func deleteItems(offsets: IndexSet) {
        do {
            let items = try viewContext.fetch(Item.fetchRequest())
            withAnimation {
                offsets.map { items[$0] }.forEach(viewContext.delete)
                saveContext()
            }
        } catch {
            print("Failed to fetch items for deletion: \(error)")
        }
    }

    // MARK: - Save Context
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error: \(nsError), \(nsError.userInfo)")
        }
    }
}
