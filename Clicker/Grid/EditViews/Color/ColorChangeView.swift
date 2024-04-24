//
//  ColorEditView.swift
//  Clicker
//
//  Created by admin on 2.04.24.
//

import SwiftUI
import CoreData

protocol Colorness : NSManagedObject{
    var color: UserColor? {get set}
}

extension Clicker : Colorness {}
extension ClickerType : Colorness {}


struct ColorChangeView<T:Colorness>: View {
    @ObservedObject var item: T
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)])
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
                
                GridView(items: colors.map{$0}, onItemTap: { color in
                    //isolate choosen color in item context
                    let itemContext = item.managedObjectContext!
                    let color = UserColor.copyForEdition(of: color as! UserColor, in: itemContext) 
                    
                    
                    item.color = color
                }, editMenuType: .color,
                         appearAddButton: true)
            }
        }
        //        .onDisappear(perform: {
        //            do {
        //                try context.save()
        //            } catch {
        //                print("Error in colorChangeView")
        //            }
        //        })
    }
}

#Preview {
    let persistence = PersistenceController.shared
    let contextForDeepUse = persistence.childViewContext
    //    let color = UserColor.oneUserColor(contextForDeepUse)
    let clicker = Clicker.oneClicker(context: persistence.container.viewContext)
    //    try? contextForDeepUse.save()
    //    clicker.color = color
    //    let viewContext = persistence.container.viewContext
    //    UserColor.tenUserColors(persistence.container.viewContext)
    //    try? persistence.container.viewContext.save()
    
    return ColorChangeView( item: clicker)
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .environmentObject(Settings())
}
