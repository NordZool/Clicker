//
//  CkickerEditView.swift
//  Clicker
//
//  Created by admin on 6.03.24.
//

import SwiftUI

struct ClickerEditView: View {
    @StateObject var viewModel: ClickerEditViewModel
    @State private var testObject: Clicker?

    var body: some View {
        Form {
            TextField("Name", text: $viewModel.clicker.name ?? "")
                .font(.title)
            HStack {
                Text("Amount:")
                Spacer()
                TextField("0", text: Binding(
                    get: {
                        "\(viewModel.clicker.amount)"
                    },
                    set: {
                        // Handle the case when the user clears the text field
                        if let value = NumberFormatter().number(from: $0) {
                            viewModel.clicker.amount = Int64(value.intValue)
                        } else {
                            viewModel.clicker.amount = 0
                        }
                    }
                ))
                .keyboardType(.numberPad)
            }
            .font(.title2)
            
            Picker("Increace value", selection: $viewModel.clicker.increaseNumber) {
                ForEach(Int16(0)..<Int16(100), id: \.self) {num in
                    Text(String(num))
                }
            }
            Picker("Reduce value", selection: $viewModel.clicker.reduceNumber) {
                ForEach(Int16(0)..<Int16(100), id: \.self) {num in
                    Text(String(num))
                }
            }
            Section("Other") {
                NavigationLink("Categories") {
                    CategoriesView( clicker:viewModel.clicker)
                }
                
                NavigationLink("Color") {
                    ColorChangeView(item: viewModel.clicker)
                }
            }
           
        }
    }
}



#Preview {
    let persistence = PersistenceController.shared
    let viewContext = persistence.container.viewContext
    let clicker = Clicker.oneClicker(context: viewContext)
    UserColor.tenUserColors(viewContext)
    clicker.addToTypes(ClickerType.oneClickerType(context: viewContext))
//    try? viewContext.save()

    return NavigationStack { ClickerEditView(viewModel: .init(context:viewContext, clicker:clicker))
            .navigationTitle("Clicker")
    }
    .environment(\.managedObjectContext, viewContext)
    .environmentObject(Settings())
    
    
}
