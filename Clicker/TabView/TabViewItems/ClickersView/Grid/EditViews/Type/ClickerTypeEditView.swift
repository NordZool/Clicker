//
//  ClickerTypeEditView.swift
//  Clicker
//
//  Created by admin on 6.04.24.
//

import SwiftUI

struct ClickerTypeEditView: View {
    @StateObject var viewModel: ClickerTypeEditViewModel
    var body: some View {
        Form {
            TextField("Name", text: $viewModel.type.name ?? "")
            Section("Other") {
                NavigationLink("Color") {
                    ColorChangeView(item: viewModel.type)
                }
            }
        }
    }
}

#Preview {
    let persistence = PersistenceController.shared
    let viewContext = persistence.container.viewContext
    return NavigationStack {
        ClickerTypeEditView(viewModel: .init(context: viewContext))
            .navigationTitle("Type")
    }
    .environmentObject(Settings())
    .environment(\.managedObjectContext, viewContext)
}
