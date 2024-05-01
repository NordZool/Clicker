//
//  ContentView.swift
//  Clicker
//
//  Created by admin on 15.02.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var currenctScreen = ScreensEnum.clickers
    
    let persistence: PersistenceController
        //used only for animate Clickers movement animation
        @State private var animate = false
    var body: some View {
            VStack {
                ClickerTabView(selection: $currenctScreen)
                
                    
            }
            
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
