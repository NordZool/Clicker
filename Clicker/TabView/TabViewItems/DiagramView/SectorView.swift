//
//  DiagramView.swift
//  Clicker
//
//  Created by admin on 6.05.24.
//

import SwiftUI
import Charts

 



struct SectorView<T: Amountness & Colorness>: View {
    @FetchRequest(sortDescriptors: []) private var clickers: FetchedResults<T>
    
    var body: some View {
        Chart(clickers.sorted(by: {$0.amount > $1.amount})) {clicker in
            if clicker.amount > 0 {
                SectorMark(angle: .value("Amount", clicker.amount), innerRadius: .ratio(0.618),outerRadius: .ratio(0.8), angularInset: 1.5)
                    .foregroundStyle(clicker.color?.UIColor ?? .gray)
                    .cornerRadius(4)
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
