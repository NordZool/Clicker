//
//  SectorList.swift
//  Clicker
//
//  Created by admin on 7.05.24.
//

import SwiftUI

struct SectorList<T: DiagramAvaliable & Colorness>: View {
    @EnvironmentObject private var settings: Settings
    @State private var selectedItem: T? = nil
    
    var items: [T]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(items) {item in
                    SectorListRow(item: item,selectedItem: $selectedItem)
//                    .sheet
                    
                }
            }
            
        }
        .sheet(item: $selectedItem,onDismiss: {selectedItem = nil}) { item in
            EditView(editMenuType: settings.diagramType, item:item)
        }
//        .environment(\.defaultMinListRowHeight, 20)
    }
    
    struct SectorListRow : View {
        @ObservedObject var item: T
        @Binding var selectedItem: T?
        
        var body: some View {
            HStack {
                Text(item.name ?? "")
                Spacer()
                Text("\(item.amount)")
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill (  item.color?.UIColor ?? .gray.opacity(0.5)))
            .padding(.horizontal, 10)
            .onTapGesture {
                selectedItem = item
            }
        }
    }
}



#Preview {
    let viewContext = PersistenceController.shared.container.viewContext
    return SectorList(items: try! viewContext.fetch(ClickerType.fetchRequest()))
        .environmentObject(Settings())
        .environment(\.managedObjectContext, viewContext)
}
