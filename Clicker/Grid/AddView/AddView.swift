//
//  AddView.swift
//  Clicker
//
//  Created by admin on 5.03.24.
//

import SwiftUI
import CoreData

struct AddView<T:NSManagedObject>: View {
    @Environment(\.dismiss) var dismiss

  
    let contextForAdd:NSManagedObjectContext
    //it's only for identify a kind of type
    let editMenuType: EditmenuType
    
    init(editMenuType: EditmenuType,_ context:NSManagedObjectContext? = nil,_ percictence: PersistenceController? = nil) {
        self.editMenuType = editMenuType
        
        //if we in edit view, and trying to work in another edit view
        if let context = context {
            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            childContext.parent = context
            self.contextForAdd = childContext
            
            //if we just open an edit view
        }else if let percictence = percictence {
            self.contextForAdd = percictence.childViewContext
        } else {
            self.contextForAdd = PersistenceController.shared.childViewContext
        }
    }
    
    var body: some View {
        //сплит ап на другие add view
        NavigationStack {
            //Group is need only for work .toolbar
            Group {
                switch editMenuType {
                case .clicker:
                    ClickerEditView(viewModel: .init(contextForAdd))
                        .navigationTitle("Clicker")
                case .clickerType:
                    Text("type")
                        .navigationTitle("Type")
                default:
                    Text("another")
                }
            }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                            Button("Add"){
                                try! contextForAdd.save()
                                if let parentContext = contextForAdd.parent {
                                    try! parentContext.save()
                                }
                                dismiss.callAsFunction()
                                
                            }
                            .font(.title3)
                    }
                    
//                    ToolbarItem(placement: .bottomBar) {
//                        HStack {
//                            Button("Try find 'Тест'") {
//                                clicker = try! PersistenceController.shared.container.viewContext.fetch(Clicker.fetchRequest()).first(where: {$0.name == "Тест"})
//                            }
//                            if let clicker = clicker {
//                                Text("Find \(clicker.name ?? "")")
//                            }
//                        }
//                    }
                }
        }
        
        
    }
}

#Preview {
    //говно не тестится, если не использовать общий персистенс
    let persistence = PersistenceController(inMemory: true)
    let context = persistence.container.viewContext
    return AddView(editMenuType: .clicker,nil, persistence)
        .environment(\.managedObjectContext, context)
        .environmentObject(Settings())
}
