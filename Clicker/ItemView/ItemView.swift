//
//  ItemView.swift
//  Clicker
//
//  Created by admin on 28.02.24.
//

import SwiftUI
import CoreData

struct ItemView<Item>: View where Item:NSManagedObject {
    var item: Item
    var body: some View {
        switch item {
        case let clicker as Clicker:
            ClickerView(clicker: clicker)
                .abstractModifier()
        case let clickerType as ClickerType:
            TypeView(type: clickerType)
                .abstractModifier()
        default:
            Text("Error 🥲")
        }
    }
}

#Preview {
    let context: NSManagedObjectContext = PersistenceController(inMemory: true).container.viewContext
    
    return ItemView(item: Clicker.oneClicker(context: context,withCustomColor: true))
        .environmentObject(Settings())
        .environment(\.managedObjectContext, context)
}
