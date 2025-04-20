//
//  AddItemView.swift
//  CoreData_CRUD_Operations.swiftUI
//
//  Created by Akshaya Gunnepalli on 19/04/25.
//

import SwiftUI

struct AddItemView: View {
    @State var itemName : String = ""
    @State var itemId : String = ""
    @Environment(\.dismiss) var dismiss
    var prefillData : Item?
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center,spacing: 20) {
                TextField("Enter Item Name", text: $itemName)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.black.opacity(0.1))
                    )
                TextField("Enter Item Id", text: $itemId)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.black.opacity(0.1))
                    )
                Button {
                    if let prefillData = prefillData {
                        DataManager.shared.updateItem(prefillData, with: DataModel(name: itemName,id: itemId))
                    } else {
                        DataManager.shared.addItem(model: DataModel(name: itemName, id: itemId))
                    }
                    dismiss()
                    
                } label: {
                    Text(prefillData != nil ? "Update" : "Add item")
                }
                .padding()
                .frame(width: 150,height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.blue.opacity(0.1))
                )
                Spacer()
                
            }
            .padding()
            .frame(maxHeight: .infinity)
            
        }
        .padding(.top)
        .onAppear {
            if let data = prefillData {
                itemId = data.identity ?? ""
                itemName = data.name ?? ""
            }
        }
    }
}

#Preview {
    AddItemView()
}
