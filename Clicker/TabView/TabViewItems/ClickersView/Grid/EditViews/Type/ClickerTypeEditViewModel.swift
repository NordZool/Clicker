//
//  ClickerTypeEditViewModel.swift
//  Clicker
//
//  Created by admin on 6.04.24.
//

import CoreData

class ClickerTypeEditViewModel : ObservableObject{
    let context: NSManagedObjectContext
    @Published var type: ClickerType
    
    init(context: NSManagedObjectContext, type: ClickerType? = nil) {
        self.context = context
        if let type = type {
            self.type = ClickerType.copyForEdition(of: type, in: context)
        } else {
            self.type = ClickerType.emptyClickerType(context)
        }
//        self.type = type
    }
}
