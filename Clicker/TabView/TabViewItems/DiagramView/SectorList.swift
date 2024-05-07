//
//  SectorList.swift
//  Clicker
//
//  Created by admin on 7.05.24.
//

import SwiftUI

struct SectorList<T: Amountness & Colorness>: View {
     var items: [T]
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                ForEach(items) {item in
                    HStack {
                        Text(item.name ?? "")
                        Spacer()
                        Text("\(item.amount)")
                    }
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill (  item.color?.UIColor ?? .gray.opacity(0.5)))
                    .padding(.horizontal, 10)
                    
                    
                }
            }
        }
//        .environment(\.defaultMinListRowHeight, 20)
    }
}

#Preview {
    let viewContext = PersistenceController.shared.container.viewContext
    return SectorList(items: try! viewContext.fetch(Clicker.fetchRequest()))
}
