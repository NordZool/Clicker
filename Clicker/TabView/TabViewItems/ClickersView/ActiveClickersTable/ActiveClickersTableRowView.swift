//
//  ActiveClickersTableRowView.swift
//  Clicker
//
//  Created by admin on 17.04.24.
//

import SwiftUI

struct ActiveClickersTableRowView: View {
   var clicker: Clicker
    
    var body: some View {
        HStack {
            Text(clicker.name ?? "")
                .lineLimit(1)
            Spacer()
            Text(String(clicker.amount))
        }
        .listRowBackground(clicker.color?.UIColor ?? Color(uiColor: .systemBackground))
//        .onTapGesture {
//            clicker.isActive = false
//        }
//        .animation(.linear(duration: 0.2), value: clicker.isActive)
    }
}

#Preview {
    let persistence = PersistenceController.shared
    let clicker = Clicker.oneClicker(context: persistence.container.viewContext
                                     , withCustomColor: true)
    return ActiveClickersTableRowView(clicker:clicker)
}
