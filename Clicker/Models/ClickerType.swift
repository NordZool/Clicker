import CoreData


extension ClickerType {
    //only for preview
    static func oneClickerType(context: NSManagedObjectContext, withColor:Bool = false) -> ClickerType {
        let clickerType = ClickerType(context: context)
        clickerType.name = "Preview Type"
        clickerType.timestamp = .now
        
        if withColor {
            let color = UserColor(context: context)
            color.red = Double.random(in: 0...255)
            color.green = Double.random(in: 0...255)
            color.blue = Double.random(in: 0...255)
            
            clickerType.color = color
        }
        
        return clickerType
    }
    
    //only for preview
    
    static func tenClickerTypes(context:NSManagedObjectContext, withColor:Bool = false) -> [ClickerType] {
        var clickerTypes: [ClickerType] = []
        
        for _ in 0...10 {
            let clickerType = oneClickerType(context: context, withColor: withColor)
            clickerTypes.append(clickerType)
        }
        return clickerTypes
    }
    
}
