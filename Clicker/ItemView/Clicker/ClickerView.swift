//
//  ClickerView.swift
//  Clicker
//
//  Created by admin on 28.02.24.
//

import SwiftUI
import CoreData

struct ClickerView: View {
    @ObservedObject var clicker: Clicker
    @EnvironmentObject private var settings: Settings
    var body: some View {
        VStack {
            VStack(alignment:.center, spacing: 10) {
                Text(clicker.name ?? "")
                    .fontWeight(.medium)
                
                
                Text(String(clicker.amount))
                    .fontWeight(.bold)
                    .lineLimit(1)
                
            }
            .padding(4)
            .frame(width: settings.itemSize,height: settings.itemSize)
            .background((clicker.color?.UIColor ??  Color(uiColor: .systemBackground)))
            
            //if clicker  isActive
//            .opacity(clicker.isActive ? 0.5 : 1)
//            .animation(.linear(duration:0.2), value: clicker.isActive)
        }
    
    }
}

#Preview {
    let context = PersistenceController(inMemory:true).container.viewContext
    let settings = Settings()
    return ClickerView(clicker: Clicker.oneClicker(context: context,withCustomColor: false))
        .environment(\.managedObjectContext, context)
        .abstractModifier()
        .environmentObject(settings)
        .onAppear {
            settings.itemSize = 80
        }
        
    
}
