import CoreData

//only for preview
extension ClickerType {
    
    @discardableResult static func oneClickerType(context: NSManagedObjectContext, withColor:Bool = false) -> ClickerType {
        let clickerType = ClickerType(context: context)
        clickerType.name = "Preview Type"
        clickerType.timestamp = .now
        
        if withColor {
            clickerType.color = UserColor.oneUserColor(context)
        }
        
        return clickerType
    }
    
    @discardableResult static func tenClickerTypes(context:NSManagedObjectContext, withColor:Bool = false) -> [ClickerType] {
        var clickerTypes: [ClickerType] = []
        
        for _ in 0...10 {
            let clickerType = oneClickerType(context: context, withColor: withColor)
            clickerTypes.append(clickerType)
        }
        return clickerTypes
    }
    
}


extension ClickerType {
    
    static func emptyClickerType(_ context:NSManagedObjectContext) -> ClickerType {
        let newClickerType = ClickerType(context: context)
        newClickerType.timestamp = .now
        return newClickerType
    }
    
    static func copyForEdition(of type: ClickerType, in context:NSManagedObjectContext) -> ClickerType{
        guard let object = Functions.copyForEdition(of: type, in: context) as? ClickerType else {
            fatalError("Copy clicker error")
        }
        
        return object
    }
}

//for protocol "Amountable" in "DiagramView"
extension ClickerType {
   var amount: Int64 {
       get {
           35
       }
       set {
           
       }
   }
}

extension ClickerType : DiagramAvaliable, Colorness {}
