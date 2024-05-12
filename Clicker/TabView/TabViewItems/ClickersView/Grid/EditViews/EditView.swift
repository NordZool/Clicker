//
//  AddView.swift
//  Clicker
//
//  Created by admin on 5.03.24.
//

import SwiftUI
import CoreData

struct EditView<T:NSManagedObject>: View {
    @Environment(\.dismiss) var dismiss
    //only for item != nil case
    
    let contextForAdd:NSManagedObjectContext
    //it's only for identify a kind of item type
    //cannot use item in switch because sometimes
    //it can be nil
    let editMenuType: EditmenuType
    let item:T?
    
    init(editMenuType: EditmenuType,item:T? = nil, _ context:NSManagedObjectContext? = nil) {
        self.editMenuType = editMenuType
        self.item = item
        
        //if we in edit view, and trying to work in another edit view
        //in add view always been childViewContext
        if let context = context {
            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            childContext.parent = context
            self.contextForAdd = childContext
            
            //if we just open an edit view
        } else {
            self.contextForAdd = PersistenceController.shared.childViewContext
        }
        
        self.contextForAdd.automaticallyMergesChangesFromParent = true
    }
    
    var body: some View {
        NavigationStack {
            //Group is need only for work .toolbar
            Group {
                //splitup on other add views
                switch editMenuType {
                case .clicker:
                    ClickerEditView(viewModel:.init(context:contextForAdd,
                                                    clicker: item as? Clicker))
                case .clickerType:
                    ClickerTypeEditView(viewModel: .init(context: contextForAdd,
                                                         type: item as? ClickerType))
                case .color:
                    ColorEditView(viewModel: .init(context: contextForAdd,
                                                   color: item as? UserColor))
                    
                }
            }
            .submitLabel(.done)
            .scrollDisabled(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    
                    //if is a new item is "Add" lable
                    //if is an existed item is "Save" lable
                    Button(item == nil ? "Add" : "Save"){
                        save()
                        dismiss.callAsFunction()
                    }
                    .font(.title3)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image(systemName: "multiply")
                            .padding(6)
                            .background(.gray.opacity(0.3))
                            .contentShape(Circle())
                            .containerShape(Circle())
                    }
                    .buttonStyle(.plain)
                    
                }
            }
        }
        
        
    }
    
    func save() {
        try! contextForAdd.save()
        if let parentContext = contextForAdd.parent {
            try! parentContext.save()
        }
    }
}

#Preview {
   //    let persistence = PersistenceController(inMemory: true)
    let persistence = PersistenceController.shared
    let context = persistence.container.viewContext
    return EditView(editMenuType: .clicker,nil)
        .environment(\.managedObjectContext, context)
        .environmentObject(Settings())
}
