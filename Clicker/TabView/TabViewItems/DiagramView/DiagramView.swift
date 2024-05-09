//
//  DiagramView.swift
//  Clicker
//
//  Created by admin on 6.05.24.
//

import SwiftUI
import CoreData
import Charts





//protocol Amountable {
//    var amount: Int64 {get}
//}
//
//extension  ClickerType : Amountable {}
//extension Clicker : Amountable {}
//
struct DiagramView: View {
    @EnvironmentObject private var settings: Settings
    @State private var isFilterViewPresented = false
    
    var currentTittle: String {
        switch settings.diagramType {
        case .clicker:
            "Clickers"
        case .clickerType:
            "Types"
        default:
            "Error"
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch settings.diagramType {
                case .clicker:
                    SectorView<Clicker>()
                case .clickerType:
                    SectorView<ClickerType>()
                default:
                    Text("Error")
                }
            }
            .navigationTitle(currentTittle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isFilterViewPresented = true
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }

                }
            }
            .sheet(isPresented: $isFilterViewPresented, content: {
                DiagramFilterView(diagramType: $settings.diagramType)
            })
        }
    }
}

//
#Preview {
    DiagramView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(Settings())
}
