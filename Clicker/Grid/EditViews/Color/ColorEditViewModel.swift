import CoreData

class ColorEditViewModel : ObservableObject {
    let context: NSManagedObjectContext
    @Published var color: UserColor
    
    init(context: NSManagedObjectContext, color: UserColor? = nil) {
        self.context = context
        if let color = color {
            self.color = UserColor.copyForEdition(of: color, in: context)
        } else {
            self.color = UserColor.emptyUserColor(context)
        }
    }
}
