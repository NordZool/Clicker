//
//  ClickerTabView.swift
//  Clicker
//
//  Created by admin on 24.04.24.
//

import SwiftUI

struct ClickerTabView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
            VStack {
                TabView(selection: $settings.currentScreen) {
                        ClickersView()
                        .tag(ScreensEnum.clickers)

                        Text("Lol1")
                    
                        .tag(ScreensEnum.graphic)
                        SettingsView()
                            .tag(ScreensEnum.settings)
                            .navigationTitle("Test")
                           
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                //line between TabView and TabViewBar
                Divider()
                    .padding(.top, -8)
                ClickerTabViewBar(screenInView: $settings.currentScreen)
            }
        
    }
}

fileprivate struct PreviewClickerTabView : View {
    @State private var selection = ScreensEnum.clickers
    
    var body: some View {
            ClickerTabView()
            //                .toolbar {
            //                    ToolbarItem(placement: .bottomBar) {
            //                        ClickerTabViewBar(screenInView: $selection)
            //                    }
            //                }
        
        .environmentObject(Settings())
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

#Preview {
    PreviewClickerTabView()
}
