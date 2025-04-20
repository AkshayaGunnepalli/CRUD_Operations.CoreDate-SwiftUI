//
//  ContentView.swift
//  CoreData_CRUD_Operations.swiftUI
//
//  Created by Akshaya Gunnepalli on 19/04/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack {
                GroupBox{
                    HStack {
                        NavigationLink("Add Item") {
                            AddItemView()
                        }
                        Spacer()
                        EditButton()
                    }
                }
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            AddItemView(prefillData: item)
                        } label: {
                            HStack {
                                Text(item.name ?? "")
                                Spacer()
                                Text(item.timestamp!, formatter: itemFormatter)
                            }
                            .padding(.horizontal,10)
                        }
                    }
                    .onDelete(perform: DataManager.shared.deleteItems)
                   
                }
            }
            .padding(.horizontal) 
        }
        
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

