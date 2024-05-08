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
    
    
    var body: some View {
       Spliter(items: rawItems.filter({$0.isActiveOnDiagram}).sorted(by: {$0.amount > $1.amount}))
    }
    
    //I use this view for do filter{} and sorted{} just one single time
    struct Spliter : View {
        var items: [T]
        
        var body: some View {
            ScrollView {
                VStack {
                    Chart {
                        ForEach(items) {item in
                            if  item.amount >= 0 {
                                SectorMark(angle: .value("Amount", item.amount), innerRadius: .ratio(0.618),outerRadius: .ratio(0.9), angularInset: 3)
                                    .foregroundStyle(item.color?.UIColor ?? .gray)
                                    .cornerRadius(6)
                                    
                                    
                            }
                            
                        }
                    }
                    
                    .frame(width: .infinity, height: 400)
                    Divider()
                    SectorList(items: items)
                }
             }
        }
        
        
    }

}

fileprivate struct SectorPreview : View {
    
    var body: some View {
        SectorView<Clicker>()
    }
}

#Preview {
    SectorPreview()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
