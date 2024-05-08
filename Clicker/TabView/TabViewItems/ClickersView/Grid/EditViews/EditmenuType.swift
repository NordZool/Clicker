import Foundation

//Conform to Codable for using in Settings.diagramType property
//CaseIterable for DiagramFilterView
enum EditmenuType : Codable, CaseIterable{
    case clicker
    case clickerType
    case color
}
