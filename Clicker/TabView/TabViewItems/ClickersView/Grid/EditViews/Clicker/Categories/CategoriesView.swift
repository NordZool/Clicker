//
//  CategoriesView.swift
//  Clicker
//
//  Created by admin on 30.03.24.
//

import SwiftUI
import CoreData

struct CategoriesView: View {
    @FetchRequest(
        entity: ClickerType.entity(),
        sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)])
    var notRelatedClickerTypes: FetchedResults<ClickerType>
    //only for trigger animate, value is not matter
    @State private var animate: Bool = true
    @ObservedObject var clicker: Clicker
    
    var body: some View {
        ScrollView {
            GridView(items: clicker.typesArraySortedByDate(),
                     onItemTap: { clickerType in
                self.tapOnActiveType(type: clickerType )
                animate.toggle()
            }, editMenuType: .clickerType, appearAddButton: false)
            
            //user's guide
            if (clicker.types as! Set<ClickerType> ).isEmpty {
                Text("Tap on type to add it to clicker")
                    .font(.title2)
            }
            Text((clicker.types as! Set<ClickerType> ).isEmpty ? "Long tap to edit" : "Tap on type to unbound it with clicker")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Rectangle()
                .frame(height: 3)
            
            //GridView with items, that not contains in clicker.types
            GridView(items: notRelatedClickerTypes.filter{type in
                !(((clicker.types as? Set<ClickerType>) ?? [])
                    .contains(where:{$0.objectID == type.objectID}))
            }, onItemTap: {clickerType in
                self.tapOnUnactriveType(type: clickerType , in: clicker.managedObjectContext!)
               
                animate.toggle()
            }, editMenuType: .clickerType,
                     appearAddButton: true
            )
        }
        .animation(Resourses.gridAnimation, value: animate)
//        .onDisappear {
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    print("error during saving in Categories view: \(error)")
//                }
//            }
//        }
        
    }
    
    func tapOnUnactriveType(type: ClickerType, in context: NSManagedObjectContext) {
        //isolate choosen type in clicker context
        let type = ClickerType.copyForEdition(of: type, in: context)
        //for move it in the end of the list
        type.timestamp = .now
        
        clicker.addToTypes(type)
    }
    
    private func tapOnActiveType(type: ClickerType) {
        clicker.removeFromTypes(type)
        //for move it in the end of the list
        type.timestamp = .now
        
    }
}

#Preview {
    let persistens = PersistenceController(inMemory: true)
    let context = persistens.container.viewContext
    let clicker = Clicker.oneClicker(context: context)
    for _ in 0...10 {
        
        clicker.addToTypes(ClickerType.oneClickerType(context: context))
    }
    
    return CategoriesView(clicker: clicker)
        .environmentObject(Settings())
        .environment(\.managedObjectContext, persistens.container.viewContext)
}
