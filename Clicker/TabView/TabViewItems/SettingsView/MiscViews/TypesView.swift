//
//  TypesView.swift
//  Clicker
//
//  Created by admin on 1.05.24.
//

import SwiftUI

struct TypesView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)])
    private var types: FetchedResults<ClickerType>
    
    var body: some View {
        GridView(items: types.map({$0}), onItemTap: { _ in }, editMenuType: .clickerType, appearAddButton: true)
    }
}

#Preview {
    TypesView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(Settings())
}
