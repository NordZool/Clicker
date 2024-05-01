//
//  ActiveClickersTableView.swift
//  Clicker
//
//  Created by admin on 13.04.24.
//

import SwiftUI

struct ActiveClickersTableView: View {
    @FetchRequest(
        entity: Clicker.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Clicker.timestamp, ascending: true)],
        predicate: NSPredicate(format: "isActive == %@", NSNumber(value:true)),animation: Resourses.gridAnimation)
    private var clickers: FetchedResults<Clicker>
    
    //for increase/reduce clicker operation saving
    @Environment(\.managedObjectContext) private var moc
    var body: some View {
        
        ScrollView {
            
            GridView(items: clickers.map({$0}), onItemTap: { object in
                let clicker = object as! Clicker
                
                   
                clicker.timestamp = .now
                clicker.isActive = false
                
                if let context = clicker.managedObjectContext {
                    try! context.save()
                }
            }, editMenuType: .clicker, appearAddButton: false)
            
            //user's guide
            VStack {
                    if clickers.isEmpty {
                            Text("Tap on clicker to start counting it")
                                .font(.title2)
                            Text("Long tap to edit")
                                .font(.title3)
                                .foregroundStyle(.gray)
                    }
                //without 'if else' statement for best animation
                    
            }
            .transaction { transaction in
                transaction.animation = clickers.isEmpty ? Resourses.gridAnimation : nil
            }
            if !clickers.isEmpty {
            Text( "Tap on clicker to stop counting it")
                .font(.title3)
                .foregroundStyle(.gray)
            }
            
        }
//        .toolbar {
//            ToolbarItem(placement:.topBarLeading) {
//                Button {
//                    clickers.forEach { clicker in
//                        clicker.reduceOperation()
//                        
//                    }
//                    try! moc.save()
//                } label: {
//                    Image(systemName: "minus")
//                }
//            }
//            
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    clickers.forEach { clicker in
//                        clicker.increaseOperation()
//                        
//                    }
//                    try! moc.save()
//                } label: {
//                    Image(systemName: "plus")
//                }
//            }
//        }
        
    }
}

#Preview {
    let persistense = PersistenceController.shared
    let viewContext = persistense.container.viewContext
    return NavigationStack{ ActiveClickersTableView()}
        .environment(\.managedObjectContext, viewContext)
        .environmentObject(Settings())
}
