//
//  InactiveClickersTableView.swift
//  Clicker
//
//  Created by admin on 30.04.24.
//

import SwiftUI

struct InactiveClickersTableView: View {
    @FetchRequest(
        entity: Clicker.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Clicker.timestamp, ascending: true)],
        predicate: NSPredicate(format: "isActive == %@", NSNumber(value:false)),animation: Resourses.gridAnimation)
    private var clickers: FetchedResults<Clicker>
    
    var body: some View {
        GridView(items: clickers.map({$0}), onItemTap: { object in
            let clicker = object as! Clicker
            clicker.timestamp = .now
            clicker.isActive = true
            
            if let context = clicker.managedObjectContext {
                try! context.save()
            }
        }, editMenuType: .clicker, appearAddButton: true)
    }
}


//
//#Preview {
//    InactiveClickersTableView()
//}
