//
//  DiagramFilterView.swift
//  Clicker
//
//  Created by admin on 8.05.24.
//

import SwiftUI
import CoreData

struct DiagramFilterView: View {
    
    @Binding var diagramType: EditmenuType
    var body: some View {
        VStack {
            
            switch diagramType {
            case .clicker:
                DiagramFilterItemsView<Clicker>(itemsType: diagramType)
            case .clickerType:
                DiagramFilterItemsView<ClickerType>(itemsType: diagramType)
            default:
                Text("Error")
            }
            Picker(selection: $diagramType.animation(.linear)) {
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
    @FetchRequest(sortDescriptors: [], animation: Resourses.gridAnimation) var items: FetchedResults<T>
    @EnvironmentObject var settings: Settings
    let itemsType: EditmenuType
    
    var body: some View {
        ScrollView {
            
            if settings.guidance {
                Text("Tap to hide a cell from the chart")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.top, 15)
            }
            
            GridView(
                items: items.sorted(by: {($0.amount > $1.amount)}),
                onItemTap: {item in
                    withAnimation(.easeOut(duration: 0.3)) {
                        item.isActiveOnDiagram.toggle()
                        let context = item.managedObjectContext
                        try! context?.save()
                    }
                    
                },itemModifier: {item in
                    DiagramItemModifier(item: item)
                },
                editMenuType: itemsType,
                appearAddButton: false)
        }
    }
    
    struct DiagramItemModifier :ViewModifier{
        @ObservedObject var item: T
        
        func body(content: Content) -> some View {
            content
                .opacity(item.isActiveOnDiagram ? 1 : 0.15)
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
