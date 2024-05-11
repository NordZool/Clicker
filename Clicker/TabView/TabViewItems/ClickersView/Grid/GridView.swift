//
//  GridView.swift
//  Clicker
//
//  Created by admin on 5.03.24.
//

import SwiftUI
import CoreData


extension GridView where V == EmptyModifier {
    init(items:[T], onItemTap: @escaping (T) -> (), editMenuType: EditmenuType,appearAddButton:Bool, context: NSManagedObjectContext? = nil) {
        self.itemModifier = {_ in  EmptyModifier()}
        
        self.items = items
        self.onItemTap = onItemTap
        self.editMenuType = editMenuType
        self.appearAddButton = appearAddButton
        self.context = context
    }
}

struct GridView<T:NSManagedObject & Identifiable, V:ViewModifier>: View {
    @EnvironmentObject private var settings: Settings
    @State private var addViewIsPresented = false
    //for present the editView
    @State private var editableItem: T? = nil
    
    var items: [T]
    let onItemTap: (T) -> ()
    let itemModifier: (T) -> (V)
    let editMenuType: EditmenuType
    let appearAddButton:Bool
    //this context shoud only be as viewContext or empty
    var context: NSManagedObjectContext?
  
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: settings.itemSize, maximum: settings.itemSize),spacing: 10)], content: {
                ForEach(items) {item in
                    ItemView(item: item)
                        .modifier(itemModifier(item))
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
                               
//                               .modifier(itemModifier)
                    
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
                            .background(.secondary)
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
    
//    private var modifier: some ViewModifier {
//        if let modifier = itemModifier {
//            return modifier
//        } else {
//            return EmptyModifier() 
//        }
//    }
}

#Preview {
    let persistence = PersistenceController.shared
    let context = persistence.container.viewContext
    return GridView(
        items: try! context.fetch(Clicker.fetchRequest()),
        onItemTap: {_ in
        }, editMenuType: .clicker, appearAddButton: true)
    
    .environment(\.managedObjectContext, context)
    .environmentObject(Settings())
}
