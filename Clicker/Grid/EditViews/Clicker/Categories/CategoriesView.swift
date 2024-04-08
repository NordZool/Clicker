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
                     onItemTap: { object in
                let type = object as! ClickerType
                clicker.removeFromTypes(type)
                animate.toggle()
            }, editMenuType: .clickerType, appearAddButton: false)
            
            Divider()
            
            //GridView with items, that not contains in clicker.types
            GridView(items: notRelatedClickerTypes.filter{type in
                !(((clicker.types as? Set<ClickerType>) ?? [])
                    .contains(where:{$0.objectID == type.objectID}))
            }, onItemTap: {object in
                //isolate choosen color in item context
                let clickerContext = clicker.managedObjectContext!
                let type = ClickerType.copyForEdition(of: object as! ClickerType, in: clickerContext) 
                
                
                clicker.addToTypes(type)
                animate.toggle()
            }, editMenuType: .clickerType,
                     appearAddButton: true
            )
//            .animation(.interpolatingSpring(stiffness: 30, damping: 8, initialVelocity: 4))
            //            ForEach(notRelatedClickerTypes) {type in
            //                Text(String(!(((clicker.types as? Set<ClickerType>) ?? []).contains(where: {$0.objectID == type.objectID}))))
            //            }
            //            Button("Save") {
            //                if context.hasChanges {
            //                    do {
            //                        try context.save()
            //                    } catch {
            //                        print("error during saving in Categories view: \(error)")
            //                    }
            //                }
            //            }
            //            Button("Create type") {
            //                let new = ClickerType.oneClickerType(context: context)
            //                new.name = "последний"
            //                do {
            //                    try context.save()
            //                    if let parent = context.parent {
            //                        try parent.save()
            //                    }
            //                } catch {
            //                    print(error)
            //                }
            //            }
        }
        .animation(.interpolatingSpring(stiffness: 40, damping: 10, initialVelocity: 1), value: animate)
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
}

#Preview {
    let persistens = PersistenceController(inMemory: false)
    let context = persistens.childViewContext
    let clicker = Clicker.oneClicker(context: context)
    clicker.addToTypes(ClickerType.oneClickerType(context: context))
    
    return CategoriesView(clicker: clicker)
        .environmentObject(Settings())
        .environment(\.managedObjectContext, persistens.container.viewContext)
}
