//
//  EmptyGridItem.swift
//  Clicker
//
//  Created by admin on 1.05.24.
//

import SwiftUI

struct SampleGridView : View {
    @EnvironmentObject private var settings:Settings
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: settings.itemSize, maximum: settings.itemSize),spacing: 10)], content: {
                EmptyGridItem(label: "Test")
                EmptyGridItem(label: "Test")
                EmptyGridItem(label: "Test")
            })
        }
//        .padding(10)
        
    }
}

 struct EmptyGridItem: View {
    @EnvironmentObject private var settings: Settings
    let label: String
    let color: Color = .clear
    var body: some View {
        Text(label)
            .fontWeight(.medium)
            .frame(width: settings.itemSize,height: settings.itemSize)
            .background(color)
            .abstractModifier()
            
        
    }
}

#Preview {
    SampleGridView()
        .environmentObject(Settings())
}
