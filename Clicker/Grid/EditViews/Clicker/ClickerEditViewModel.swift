import Foundation
import CoreData

class ClickerEditViewModel : ObservableObject {
    let context: NSManagedObjectContext
    @Published var clicker: Clicker
    
    //if view is Edit - clicker isn't nil
    //else it is Add view - create new empty clicker
    init(_ context: NSManagedObjectContext, clicker: Clicker? = nil) {
        self.context = context
        
        if let clicker = clicker {
            self.clicker = Clicker.copyForEditiong(of: clicker, in: context)
        } else {
            self.clicker = Clicker.emptyClicker(context: context)
        }
        
    }
    
    func rollBack() {
        if context.hasChanges {
            context.rollback()
        }
    }
    
  
}
