//
//  ColorsView.swift
//  Clicker
//
//  Created by admin on 1.05.24.
//

import SwiftUI

struct ColorsView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)])
    private var colors: FetchedResults<UserColor>
    
    var body: some View {
        GridView(items: colors.map({$0}), onItemTap: { _ in }, editMenuType: .color, appearAddButton: true)
    }
}

#Preview {
    ColorsView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(Settings())
}
