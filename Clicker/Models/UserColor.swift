import SwiftUI
import CoreData

//only for preview
extension UserColor {
    @discardableResult static func oneUserColor(_ context: NSManagedObjectContext) -> UserColor {
        let newColor = UserColor(context: context)
        
        newColor.blue = Double.random(in: 0..<255)
        newColor.red = Double.random(in: 0..<255)
        newColor.green = Double.random(in: 0..<255)
        newColor.timestamp = .now + .random(in: 0..<1000)
        
        return newColor
    }
    
    @discardableResult static func tenUserColors(_ context: NSManagedObjectContext) -> [UserColor] {
        var result = [UserColor]()
        
        for _ in 0..<10 {
            result.append(oneUserColor(context))
        }
        
        return result
    }
}


//max value for red/green/blue is 255
extension UserColor {
    var UIColor: Color {
        Color(red: self.red / 255, green: self.green / 255, blue: self.blue / 255)
    }
    
    static func emptyUserColor(_ context: NSManagedObjectContext) -> UserColor {
        UserColor(context: context)
    }
    
    static func copyForEdition(of color: UserColor, in context:NSManagedObjectContext) -> UserColor{
        guard let object = try? context.existingObject(with: color.objectID) as? UserColor else {
            fatalError("Copy color error")
        }
        
        
        return object
    }
}
