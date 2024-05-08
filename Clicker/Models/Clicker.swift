import CoreData

//static functions
extension Clicker{
    //only for preview!!
    @discardableResult static func oneClicker(context: NSManagedObjectContext, withCustomColor:Bool = false) -> Clicker {
        let clicker = Clicker(context: context)
        clicker.timestamp = Date.now
        clicker.name = "Preview Clicker"
        clicker.amount = 228
        
        
        if withCustomColor {
            let color = UserColor(context: context)
            color.red = Double.random(in: 0...255)
            color.green = Double.random(in: 0...255)
            color.blue = Double.random(in: 0...255)
            
            clicker.color = color
        }
        
        return clicker
    }
    
    //only for preview
    @discardableResult static func clickers(context: NSManagedObjectContext,_ count:Int, _ withCustomColor:Bool = false) -> [Clicker] {
        var clickers: [Clicker] = []
        for _ in 0...count {
            let clicker = oneClicker(context: context, withCustomColor: withCustomColor)
            clickers.append(clicker)
        }
        
        return clickers
    }
    
    static func emptyClicker(context:NSManagedObjectContext) -> Clicker {
       let clicker = Clicker(context: context)
        clicker.timestamp = .now
        clicker.name = ""
        
        return clicker
    }
    
    
    
    static func copyForEdition(of clicker: Clicker, in context:NSManagedObjectContext) -> Clicker{
        guard let object = Functions.copyForEdition(of: clicker, in: context) as? Clicker else {
            fatalError("Copy clicker error")
        }
        
        
        return object
    }
    
}


//no static functions
extension Clicker {
    func typesArraySortedByDate() -> [ClickerType] {
        (self.types as? Set<ClickerType>)?
            .sorted(by: {$0.timestamp ?? .now < $1.timestamp ?? .now})
        ?? []
    }

    func increaseOperation() {
        self.amount += Int64(self.increaseNumber)
    }
    
    func reduceOperation() {
        self.amount -= Int64(self.reduceNumber)
    }
    
}

extension Clicker : DiagramAvaliable, Colorness {}
