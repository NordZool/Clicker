import Foundation

final class Settings : ObservableObject {
    //optimal range for this is from 70 to 180
    //used in GridItem and in .frame() modifier of ClickerView and TypeView
    @Published var itemSize: CGFloat {
        didSet {
            Settings.encode(data: itemSize, for: userDefaultsKey_itemSize)
        }
    }
    
    init() {
        //init data for 'itemSize' from UD
        //standart size is 80
        itemSize = Settings.decode(for: userDefaultsKey_itemSize) ?? 80
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
}
