//
//  DiagramFilterView.swift
//  Clicker
//
//  Created by admin on 8.05.24.
//

import SwiftUI
import CoreData

struct DiagramFilterView: View {
    //    @FetchRequest(sortDescriptors: []) var items: FetchedResults<T>
    
    @Binding var diagramType: EditmenuType
    var body: some View {
        VStack {
            switch diagramType {
            case .clicker:
                DiagramFilterItemsView<Clicker>(itemsType: diagramType)
            case .clickerType:
//                DiagramFilterItemsView<ClickerType>(itemsType: diagramType)
                Text("Test")
            default:
                Text("Error")
            }
            Picker(selection: $diagramType) {
                //drop .color (not supportes)
                ForEach(EditmenuType.allCases.dropLast(1), id:\.self) {type in
                    Text(typeTyString(type))
                }
            } label: {
                Text(typeTyString(diagramType))
            }
            .pickerStyle(.segmented)
        }
        
    }
    
    func typeTyString(_ type:EditmenuType) -> String {
        switch type {
        case .clicker:
            "Clickers"
        case .clickerType:
            "Types"
        default:
            "Error"
        }
    }
}


struct DiagramFilterItemsView<T:DiagramAvaliable> : View {
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<T>
    let itemsType: EditmenuType
    
    var body: some View {
        GridView(
            items: items.sorted(by: {($0.amount > $1.amount)}),
            onItemTap: {item in
                item.isActiveOnDiagram.toggle()
            },itemModifier: {item in
                DiagramItemModifier(isActiveOnDiagram: item.isActiveOnDiagram)
            },
            editMenuType: itemsType,
            appearAddButton: false)
    }
    
    struct DiagramItemModifier :ViewModifier{
        var isActiveOnDiagram: Bool
        
        func body(content: Content) -> some View {
            content
                .opacity(isActiveOnDiagram ? 1 : 0.5)
        }
    }
}



#Preview {
    DiagramFilterView(diagramType: Binding(get: {
        .clicker
    }, set: { _ in
        
    }))
    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    .environmentObject(Settings())
}
