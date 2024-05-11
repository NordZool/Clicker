//
//  DiagramView.swift
//  Clicker
//
//  Created by admin on 6.05.24.
//

import SwiftUI
import Charts
import CoreData

 



struct SectorView<T: DiagramAvaliable & Colorness>: View {
    //Becounse I use protocols for generic I can't use
    //sortDescriptors or predicates. Thus items sorted and
    //filtered when I use these.
    @FetchRequest(sortDescriptors: []) private var rawItems: FetchedResults<T>
    @EnvironmentObject private var settings: Settings
    
    var body: some View {
        ScrollView {
        if rawItems.filter({$0.isActiveOnDiagram}).isEmpty {
            Text("You have nothing to display in the chart yet.")
                .font(.title)
                .foregroundStyle(.gray)
        } else {
                VStack {
                    Chart {
                        ForEach(rawItems.filter({$0.isActiveOnDiagram}).sorted(by: {$0.amount > $1.amount})) {item in
                            if item.amount >= 0 {
                                SectorMark(angle: .value("Amount", item.amount), innerRadius: .ratio(0.618),outerRadius: .ratio(0.9), angularInset: 3)
                                    .foregroundStyle(item.color?.UIColor ?? .gray)
                                    .cornerRadius(6)
                                
                            }
                        }
                    }
                    
                    .frame(width: 400, height: 400)
                    Divider()
                    //guidence
                    if settings.guidance {
                        Text("Tap on a row to see details")
                            .font(.title3)
                            .foregroundStyle(.gray)
                    }
                    
                    SectorList(items:  rawItems.filter({$0.isActiveOnDiagram}).sorted(by: {$0.amount > $1.amount}))
                }
            }
        }
    }
    
    //I use this view for do filter{} and sorted{} just one single time
    
    //for changing "SectorMark" when user
    //Edit item in "SectorList"
//    struct ObservedSectorMark : ChartContent {
//        @ObservedObject var item: T
//        
//        var body: some ChartContent {
//            if item.amount >= 0 {
//                SectorMark(angle: .value("Amount", item.amount), innerRadius: .ratio(0.618),outerRadius: .ratio(0.9), angularInset: 3)
//                    .foregroundStyle(item.color?.UIColor ?? .gray)
//                    .cornerRadius(6)
//                    
//            }
//        }
//    }

}

fileprivate struct SectorPreview : View {
    
    var body: some View {
        SectorView<ClickerType>()
    }
}

#Preview {
    SectorPreview()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(Settings())
}
