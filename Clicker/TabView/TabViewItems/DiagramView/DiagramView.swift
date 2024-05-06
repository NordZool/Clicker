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
    
    
    var body: some View {
        VStack {
            SectorView<Clicker>()
            Text("My list")
        }
    }
}
//
#Preview {
    DiagramView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
