//
//  SettingsView.swift
//  Clicker
//
//  Created by admin on 1.05.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settings: Settings
    
    @Environment(\.colorScheme) private var scheme
    
    @State private var colorsIsPresented = false
    @State private var typesIsPresented = false
    var body: some View {
  
        NavigationStack {
            
            Form {
                Section("APPEARANCE") {
                    HStack{
                        Text("Scale:")
                        Slider(value: $settings.itemSize, in: (73.0)...(150.0),label: {Text("Scale")})
                        
                    }
                    EmptyGridItem(label: "Example")
                        .animation(Resourses.gridAnimation, value: settings.itemSize)
                }
                
                Section("MISC") {
//                    Button("Colors") {
//                        colorsIsPresented = true
//                    }
//                    .foregroundStyle(scheme == .light ? .black : .white)
//                    .sheet(isPresented: $colorsIsPresented, content: {
//                        MiscView<UserColor>(itemsType: .color)
//                    })
                    
                    NavigationLink(destination: MiscView<UserColor>(itemsType: .color)) {
                        Text("Colors")
                    }
                    NavigationLink(destination: MiscView<ClickerType>(itemsType: .clickerType)) {
                        Text("Types")
                    }
                    
//                    Button("Types") {
//                        typesIsPresented = true
//                    }
//                    .foregroundStyle(scheme == .light ? .black : .white)
//                    .sheet(isPresented: $typesIsPresented, content: {
//                        MiscView<ClickerType>(itemsType: .clickerType)
//                    })
                }
                
            }
            .navigationTitle("Settings")
        }
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(Settings())
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
