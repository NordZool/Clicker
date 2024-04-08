//
//  ColorEditView.swift
//  Clicker
//
//  Created by admin on 2.04.24.
//

import SwiftUI
import CoreData

//when appen button pressed
struct ColorEditView: View {
    @StateObject var viewModel: ColorEditViewModel
    
    
    
    var body: some View {
        VStack {
            ItemView(item: viewModel.color)
                .padding(.bottom,10)
            //new Vstack only for sliders' spacing
            VStack(spacing:40) {
                HStack {
                    ColorIndexView(color: .red)
                    
                    Slider(value: $viewModel.color.red, in: (0.0)...(255.0)) {
                        Text("Red")
                    }
                    .tint(.red)
                }
                
                HStack {
                    ColorIndexView(color: .blue)
                    Slider(value: $viewModel.color.blue, in: (0.0)...(255.0)) {
                        Text("Blue")
                    }
                    .tint(.blue)
                }
                HStack {
                    
                    ColorIndexView(color: .green)
                    Slider(value: $viewModel.color.green, in: (0.0)...(255.0)) {
                        Text("Green")
                    }
                    .tint(.green)
                }
            }
            Spacer()
        }
        .padding(.horizontal,30)
    }
    
    private struct ColorIndexView: View {
        let color: Color
        
        var body: some View {
            Circle()
                .fill(color)
                .frame(width: 30)
        }
    }
}

#Preview {
    let persistence = PersistenceController(inMemory: true)
    
    let deepContext = persistence.childViewContext
    let color = UserColor.oneUserColor(persistence.container.viewContext)
    try? persistence.container.viewContext.save()
    let existingColor = UserColor.copyForEdition(of: color, in: deepContext)
//    let viewContext = persistence.container.viewContext
    
    return ColorEditView(viewModel: .init(context: persistence.container.viewContext,color: existingColor))
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .environmentObject(Settings())
}
