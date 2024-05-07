//
//  Protocols.swift
//  Clicker
//
//  Created by admin on 6.05.24.
//

import CoreData
import SwiftUI

//used in "ColorChangeView" and "SectorView" generics
protocol Colorness : NSManagedObject{
    var color: UserColor? {get set}
}

//used in "SectorView" generics
protocol Amountness : NSManagedObject & Identifiable{
    var amount: Int64 {get set}
    var name: String? {get set}
}
