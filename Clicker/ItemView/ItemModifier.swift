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
    @EnvironmentObject var settings: Settings
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .contentShape(ContentShapeKinds.contextMenuPreview,
                          RoundedRectangle(cornerRadius: 20))
            .multilineTextAlignment(.center)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
            }
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
        ItemView(item: Clicker.oneClicker(context: PersistenceController.shared.container.viewContext, withCustomColor: true))
            .contextMenu(menuItems: {
                /*@START_MENU_TOKEN@*/Text("Menu Item 1")/*@END_MENU_TOKEN@*/
                /*@START_MENU_TOKEN@*/Text("Menu Item 2")/*@END_MENU_TOKEN@*/
                /*@START_MENU_TOKEN@*/Text("Menu Item 3")/*@END_MENU_TOKEN@*/
            })
//        VStack {
//            //optimal range 50 <-> 180
//            Slider(value: $settings.itemSize, in: 50...180)
//            Text("Size for now is: \(settings.itemSize)")
//            
//                ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: settings.itemSize,maximum: settings.itemSize),spacing: 10,alignment: .leading)], content: {
//                            ForEach(0..<10) {_ in
//                                Text("Placeholder")
//                                    .frame(width: settings.itemSize,height: settings.itemSize)
//                                    .background(.blue)
//                                    
//                                    
//                                    
//                                    
//                            }
//                            
//                            //                .frame(height: 100)
//                        })
//                        .padding(.horizontal,10)
//                        
//                    
//                }
//                
//            
//        }
    }
}

#Preview {
    ItemModifierPreview()
        .environmentObject(Settings())
    
        
}
