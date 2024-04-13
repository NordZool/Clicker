//
//  ColorView.swift
//  Clicker
//
//  Created by admin on 2.04.24.
//

import SwiftUI

struct ColorView: View {
    @EnvironmentObject private var settings:Settings
    @ObservedObject var color: UserColor
    
    var body: some View {
        color.UIColor
            .frame(width: settings.itemSize, height: settings.itemSize)
    }
}

#Preview {
    let persistence = PersistenceController(inMemory: true)
    let viewContext = persistence.container.viewContext
    let color = UserColor.oneUserColor(viewContext)
    return ColorView(color: color)
        .environmentObject(Settings())
        .environment(\.managedObjectContext, viewContext)
        .abstractModifier()
}
