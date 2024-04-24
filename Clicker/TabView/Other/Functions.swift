import CoreData

struct Functions {
    private init(){}
    
    static func copyForEdition<T:NSManagedObject>(of object: T, in context:NSManagedObjectContext) -> NSManagedObject{
        guard let object = try? context.existingObject(with: object.objectID) else {
            fatalError("Copy color error")
        }
        
        
        return object
    }
}
