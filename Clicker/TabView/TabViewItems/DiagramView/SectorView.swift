//
//  DiagramView.swift
//  Clicker
//
//  Created by admin on 6.05.24.
//

import SwiftUI
import Charts

 



struct SectorView<T: Amountness & Colorness>: View {
    @FetchRequest(sortDescriptors: []) private var items: FetchedResults<T>
    @State private var selectedItem: T? = nil
    
    var body: some View {
       ScrollView {
           VStack {
               Chart {
                   ForEach(items.sorted(by: {$0.amount > $1.amount})) {clicker in
                       if  clicker.amount >= 0 {
                           SectorMark(angle: .value("Amount", clicker.amount), innerRadius: .ratio(0.618),outerRadius: .ratio(0.9), angularInset: 3)
                               .foregroundStyle(clicker.color?.UIColor ?? .gray)
                               .cornerRadius(6)
                               
                       }
                       
                   }
               }
               .overlay {
                   if let item = selectedItem {
                       
                   } else {
                       Text("Press on sector\n to see amount")
                           .font(.title3)
                           .multilineTextAlignment(.center)
                           .opacity(0.5)
                   }
               }
               
               .frame(width: .infinity, height: 400)
               Divider()
               SectorList(items: items.sorted(by: {$0.amount > $1.amount}))
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
