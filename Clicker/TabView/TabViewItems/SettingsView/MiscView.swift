//
//  ColorsView.swift
//  Clicker
//
//  Created by admin on 1.05.24.
//

import SwiftUI
import CoreData

//T == itemsType
struct MiscView<T:NSManagedObject & Identifiable>: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)])
    private var items: FetchedResults<T>
    @Environment(\.dismiss) private var dismiss
    private let title: String
    let itemsType: EditmenuType
    
    init(itemsType: EditmenuType) {
        self.itemsType = itemsType
        
        switch itemsType {
        case .clicker:
            title = "Clickers"
        case .clickerType:
            title = "Types"
        case .color:
            title = "Colors"
        }
    }
    
    var body: some View {
        NavigationStack {
            GridView(items: items.map({$0}), onItemTap: { _ in }, editMenuType: itemsType, appearAddButton: true)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            dismiss.callAsFunction()
                        }
                    }
                }
                .navigationTitle(title)
        }
    }
}

#Preview {
    MiscView<UserColor>(itemsType: .color)
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(Settings())
}
