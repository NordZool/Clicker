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
        VStack {
            VStack {
                Text("Settings")
                    .font(.headline)
                Divider()
            }
            .padding(.bottom,-8)
                
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
                        Button("Colors") {
                            colorsIsPresented = true
                        }
                        .foregroundStyle(scheme == .light ? .black : .white)
                        .sheet(isPresented: $colorsIsPresented, content: {
                            MiscView<UserColor>(itemsType: .color)
                        })
                        
                        Button("Types") {
                            typesIsPresented = true
                        }
                        .foregroundStyle(scheme == .light ? .black : .white)
                        .sheet(isPresented: $typesIsPresented, content: {
                            MiscView<ClickerType>(itemsType: .clickerType)
                        })
                }
                
            }
        }

        
    }
}

#Preview {
    SettingsView()
        .environmentObject(Settings())
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
