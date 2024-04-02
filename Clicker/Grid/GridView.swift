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
    @State private var isPresented = false
    
    var items: [T]
    let onItemTap: (NSManagedObject) -> ()
    let editMenuType: EditmenuType
    let appearAddButton:Bool
    //if it opening not from viewcontext
    var context: NSManagedObjectContext?
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: settings.itemSize, maximum: settings.itemSize),spacing: 10)], content: {
                ForEach(items) {item in
                    ItemView(item: item)
                        .onTapGesture {
                            self.onItemTap(item)
                        }
                }
                
                //addButtonItem
                if appearAddButton {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.bold)
                            .font(.title)
                            .frame(width: settings.itemSize, height: settings.itemSize)
                            .background(.gray)
                            .abstractModifier()
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $isPresented, content: {
                        AddView(editMenuType: editMenuType,context)
                    })
                }
                
                
                
                
            })
            .padding(.horizontal,10)
        }
    }
}

#Preview {
    let persistence = PersistenceController(inMemory: true)
    let context = persistence.container.viewContext
    return GridView(
        items: Clicker.clickers(context: context, 7),
        onItemTap: {clicker in
        let clicker = clicker as! Clicker
//        clicker.isActive = true
        }, editMenuType: .clicker, appearAddButton: true)
    .environment(\.managedObjectContext, context)
    .environmentObject(Settings())
}
