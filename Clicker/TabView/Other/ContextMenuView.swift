//
//  ContextMenuView.swift
//  Clicker
//
//  Created by admin on 13.04.24.
//

import SwiftUI
import CoreData

struct ContextMenuView<T:NSManagedObject>: View {
    @Environment(\.managedObjectContext) private var moc
    
    //item for sheet, we init for item
    @Binding var editableItem: T?
    let item:T
    
    var body: some View {
        Button {
            editableItem = item
        } label: {
            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
        }
        
        Button(role: .destructive) {
            //isolate object in viewContext for
            //not disturbe any other contexts
            let item = Functions.copyForEdition(of: item, in: moc)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    moc.delete(item)
            }
            try! moc.save()
        } label: {
            Label("Delete", systemImage:"trash")
        }
    }
}

//#Preview {
//
//}
