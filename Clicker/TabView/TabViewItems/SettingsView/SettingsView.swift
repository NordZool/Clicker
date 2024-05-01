//
//  SettingsView.swift
//  Clicker
//
//  Created by admin on 1.05.24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
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
                
                Section("Misc") {
                    NavigationLink(destination: {ColorsView()}, label: {Text("Colors")})
                    NavigationLink(destination: {TypesView()}, label: {Text("Types")})
                    
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
