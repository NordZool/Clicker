import SwiftUI


//max value for red/green/blue is 255
extension UserColor {
    var UIColor: Color {
        Color(red: self.red / 255, green: self.green / 255, blue: self.blue / 255)
    }
}
