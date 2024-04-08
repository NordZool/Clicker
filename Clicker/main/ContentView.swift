//
//  ContentView.swift
//  Clicker
//
//  Created by admin on 15.02.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Clicker.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Clicker>
    
    @State private var currenctScreen = ScreensEnum.clickers
    
    let persistence: PersistenceController

    var body: some View {
        NavigationStack {
            GridView(items: items.map({$0}), onItemTap: { clicker in
               let clicker = clicker as! Clicker
            }, editMenuType: .clicker,
            appearAddButton: true)
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Delete Test") {
//                        let context = persistence.container.viewContext
//                        let testObject = try! context.fetch(Clicker.fetchRequest()).first(where: {$0.name == "Test"})!
//                        context.delete(testObject)
//                    }
//                }
//                ToolbarItem {
//                    Button("find Test") {
//                        let context = persistence.container.viewContext
//                        let findObject = try? context.fetch(Clicker.fetchRequest()).first(where: {$0.name == "Test"})
//                        if let object = findObject {
//                            print("I find him: \(object)")
//                        } else {
//                            print("Not found")
//                        }
//                    }
//                }
                ToolbarItem(placement: .bottomBar) {
                    ClickerTabView(screenInView: $currenctScreen)
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Clicker(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

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
