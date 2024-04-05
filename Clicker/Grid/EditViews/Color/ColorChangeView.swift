//
//  ColorEditView.swift
//  Clicker
//
//  Created by admin on 2.04.24.
//

import SwiftUI
import CoreData


struct ColorChangeView: View {
    let context:NSManagedObjectContext
//    @FetchRequest(entity: ClickerType.entity(), sortDescriptors:
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    var notRelatedClickerTypes: FetchedResults<UserColor>
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    let persistence = PersistenceController(inMemory: true)
    UserColor.oneUserColor(persistence.container.viewContext)

//    let viewContext = persistence.container.viewContext
    
    return ColorChangeView(context: persistence.childViewContext)
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .environmentObject(Settings())
}
