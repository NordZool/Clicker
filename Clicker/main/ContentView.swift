//
//  ContentView.swift
//  Clicker
//
//  Created by admin on 15.02.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let persistence: PersistenceController
    var body: some View {
                ClickerTabView()
    }
}

#Preview {
    ContentView(persistence: PersistenceController.shared).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(Settings())
        .onAppear {
//            let ReqVar = NSFetchRequest(entityName: "Clicker")
//                let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
//                do { try ContxtVar.executeRequest(DelAllReqVar) }
//                catch { print(error) }
        }
       
}
