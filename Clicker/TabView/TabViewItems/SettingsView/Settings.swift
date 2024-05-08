import Foundation

final class Settings : ObservableObject {
    //optimal range for this is from 73 to 150
    //used in GridItem and in .frame() modifier of ClickerView and TypeView
    @Published var itemSize: CGFloat {
        didSet {
            Settings.encode(data: itemSize, for: userDefaultsKey_itemSize)
        }
    }
    
    @Published var currentScreen: ScreensEnum {
        didSet {
            Settings.encode(data: currentScreen, for: userDefaultsKey_currentScreen)
        }
    }
    
    //using and changing only in DiagramFilterView
    @Published var diagramType: EditmenuType {
        didSet {
            Settings.encode(data: diagramType, for: userDefaultsKey_diagramType)
        }
    }
//    @Published var itemTypeSample: EditmenuType {
//        didSet {
//            Settings.encode(data: itemTypeSample, for: userDefaultsKey_itemTypeSample)
//        }
//    }
    
    init() {
        //init data for 'itemSize' from UD
        //standart size is 80
        self.itemSize = Settings.decode(for: userDefaultsKey_itemSize) ?? 80
        self.currentScreen = Settings.decode(for: userDefaultsKey_currentScreen) ?? .clickers
        self.diagramType  = Settings.decode(for: userDefaultsKey_diagramType) ?? .clicker
//        self.itemTypeSample = Settings.decode(for: userDefaultsKey_itemTypeSample) ?? .clicker
    }
    
    static private func encode<T:Codable>(data:T, for key: String, in userDefaults:UserDefaults = .standard) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(data) {
            userDefaults.set(encodedData, forKey: key)
        }
    }
    
    static private func decode<T: Codable>(for key: String, in userDefaults:UserDefaults = .standard) -> T? {
        if let data = userDefaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let decodeData = try? decoder.decode(T.self, from: data) {
                return decodeData
            }
        }
        
        //if data couldn't find or decode
        return nil
    }
    
    //variable only for UD
    private let userDefaultsKey_itemSize = "ITEMSIZE"
    private let userDefaultsKey_currentScreen = "CURRENTSCREEN"
    private let userDefaultsKey_diagramType = "DIAGRAMTYPE"
//    private let userDefaultsKey_itemTypeSample = "ITEMSAMPLETYPE"
}
