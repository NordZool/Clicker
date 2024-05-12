//
//  ColorEditView.swift
//  Clicker
//
//  Created by admin on 2.04.24.
//

import SwiftUI
import CoreData


struct ColorChangeView<T:Colorness>: View {
    @ObservedObject var item: T
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)], animation: Resourses.gridAnimation)
    private var colors: FetchedResults<UserColor>
    //used only for case, where item.color = nil
    @EnvironmentObject private var settings: Settings
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let color = item.color {
                    Button {
                        item.color = nil
                    } label: {
                        ItemView(item: color)
                    }
                    .buttonStyle(.plain)
                    
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: settings.itemSize  - 10, height: settings.itemSize - 10)
                        .frame(width: settings.itemSize, height: settings.itemSize)
                        .abstractModifier()
                    
                    
                }
                Divider()
                
                GridView(
                    items: colors.map{$0},
                    onItemTap: { color in
                    //isolate choosen color in item context
                    let itemContext = item.managedObjectContext!
                    let color = UserColor.copyForEdition(of: color, in: itemContext) 

                    item.color = color
                    },itemModifier: {color in
                        SelectedColorModifier(userColor: color, selectedColor: $item.color)
                    },
                    editMenuType: .color,
                         appearAddButton: true)
            }
        }
    }
    
    struct SelectedColorModifier : ViewModifier {
        var userColor: UserColor?
        @Binding var selectedColor: UserColor?
        
        func body(content: Content) -> some View {
            content
                .overlay(alignment: .topTrailing) {
                    //"userColor == selectedColor" is always = "false" in real environment,
                    //becouse they exist in different contexts. So I use "objectID" instead ☺️.
                    if userColor?.objectID == selectedColor?.objectID {
                            Image(systemName: "checkmark.circle.fill")
                                .offset(x:-8,y:8)
                    }
            }
                .foregroundStyle(userColor?.objectID == selectedColor?.objectID ? .blue : .primary)

        }
    }
}

#Preview {
    let persistence = PersistenceController.shared
    let clicker = Clicker.oneClicker(context: persistence.container.viewContext)
    
    return ColorChangeView( item: clicker)
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .environmentObject(Settings())
}
