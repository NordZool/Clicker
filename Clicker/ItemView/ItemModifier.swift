//
//  ItemModifier.swift
//  Clicker
//
//  Created by admin on 29.02.24.
//

import SwiftUI



//dont use .frame() becouse color applying
//before .itemModifier in Clicker/Type view realization

//might imput .clipShape, .contentShape, .multilineTextalignment()
struct ItemModifier : ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .contentShape(RoundedRectangle(cornerRadius: 20))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .multilineTextAlignment(.center)
            
    }
}

extension View {
    func abstractModifier() -> some View{
        self.modifier(ItemModifier())
    }
}

fileprivate struct ItemModifierPreview: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        VStack {
            //optimal range 50 <-> 180
            Slider(value: $settings.itemSize, in: 50...180)
            Text("Size for now is: \(settings.itemSize)")
            
                ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: settings.itemSize,maximum: settings.itemSize),spacing: 10,alignment: .leading)], content: {
                            ForEach(0..<10) {_ in
                                Text("Placeholder")
                                    .frame(width: settings.itemSize,height: settings.itemSize)
                                    .background(.blue)
                                    
                                    
                                    
                                    
                            }
                            
                            //                .frame(height: 100)
                        })
                        .padding(.horizontal,10)
                        
                    
                }
                
            
        }
    }
}

#Preview {
    ItemModifierPreview()
        .environmentObject(Settings())
    
        
}
