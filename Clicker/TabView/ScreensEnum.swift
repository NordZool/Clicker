import Foundation

//rawValue = "systemImageString"
//Codable only for save 'currentScreen' value in 'Settings'
enum ScreensEnum : String, CaseIterable, Codable{
    case clickers = "list.bullet"
    case graphic = "circle.filled.pattern.diagonalline.rectangle"
    case settings = "gearshape.fill"
}
