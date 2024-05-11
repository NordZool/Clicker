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
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Cell scale:")
                            Slider(value: $settings.itemSize, in: (73.0)...(117.0),label: {Text("Scale")})
                            
                        }
                        EmptyGridItem(label: "Example")
                            .animation(Resourses.gridAnimation, value: settings.itemSize)
                    }
                    
                    Toggle(isOn: $settings.guidance) {
                        Text("Guidances:")
                    }
                }
                
                Section("MISC") {
                    
                    NavigationLink(destination: MiscView<UserColor>(itemsType: .color)) {
                        Text("Colors")
                    }
                    NavigationLink(destination: MiscView<ClickerType>(itemsType: .clickerType)) {
                        Text("Types")
                    }
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
