//
//  TypeView.swift
//  Clicker
//
//  Created by admin on 28.02.24.
//

import SwiftUI

struct TypeView: View {
    @EnvironmentObject var settings: Settings
    @ObservedObject var type: ClickerType
    
    var body: some View {
        ZStack(alignment:.topTrailing) {
            Text(type.name ?? "Test")
                .fontWeight(.medium)
                .frame(width: settings.itemSize, height: settings.itemSize)
                .background(type.color?.UIColor ?? .gray)
                
        }
    }
}

#Preview {
    let context = PersistenceController(inMemory: true).container.viewContext
    return TypeView(type: .oneClickerType(context: context,withColor: true)).environment(\.managedObjectContext, context)
        .abstractModifier()
        .environmentObject(Settings())

}
