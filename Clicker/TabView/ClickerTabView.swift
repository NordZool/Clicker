//
//  ClickerTabView.swift
//  Clicker
//
//  Created by admin on 24.04.24.
//

import SwiftUI

struct ClickerTabView: View {
    @Binding var selection: ScreensEnum
    
    var body: some View {
        TabView(selection: $selection) {
            ClickersView()
                .tag(ScreensEnum.clickers)
            Text("Lol1")
                .tag(ScreensEnum.graphic)
            Text("Lol2")
                .tag(ScreensEnum.settings)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

fileprivate struct PreviewClickerTabView : View {
    @State private var selection = ScreensEnum.clickers
    
    var body: some View {
        NavigationStack {
            ClickerTabView(selection: $selection)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        ClickerTabViewBar(screenInView: $selection)
                    }
                }
        }
        
            .environmentObject(Settings())
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

#Preview {
    PreviewClickerTabView()
}
