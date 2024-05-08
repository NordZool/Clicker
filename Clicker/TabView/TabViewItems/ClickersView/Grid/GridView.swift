//
//  GridView.swift
//  Clicker
//
//  Created by admin on 5.03.24.
//

import SwiftUI
import CoreData

struct GridView<T:NSManagedObject & Identifiable>: View {
    @EnvironmentObject private var settings: Settings
    @State private var addViewIsPresented = false
    //for present the editView
    @State private var editableItem: T? = nil
    
    var items: [T]
    let onItemTap: (NSManagedObject) -> ()
    let editMenuType: EditmenuType
    let appearAddButton:Bool
    //this context shoud only be as viewContext or empty
    var context: NSManagedObjectContext?
  
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: settings.itemSize, maximum: settings.itemSize),spacing: 10)], content: {
                ForEach(items) {item in
                    ItemView(item: item)
                        .onTapGesture {
                            self.onItemTap(item)
                        }
                        .contextMenu(menuItems: {
                            ContextMenuView(editableItem: $editableItem, item: item)
                            
                        })
                    
                        .sheet(item: $editableItem,
                               onDismiss: {editableItem = nil}) { item in
                            EditView(editMenuType: editMenuType, item:item, context)
                        }
                               
                               
                    
                }
                
                
                //addButtonItem
                if appearAddButton {
                    Button {
                        addViewIsPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .font(.title)
                            .frame(width: settings.itemSize, height: settings.itemSize)
                            .background(.gray.opacity(0.5))
                            .abstractModifier()
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $addViewIsPresented, content: {
                        EditView(editMenuType: editMenuType,context)
                    })
                }
                    
                
                
                
            })
            .padding(10)
            
        }
    }
}

#Preview {
    let persistence = PersistenceController.shared
    let context = persistence.container.viewContext
    return GridView(
        items: try! context.fetch(Clicker.fetchRequest()),
        onItemTap: {clicker in
            let clicker = clicker as! Clicker
            //        clicker.isActive = true
//          clicker.objectID
        }, editMenuType: .clicker, appearAddButton: true)
    
    .environment(\.managedObjectContext, context)
    .environmentObject(Settings())
}
