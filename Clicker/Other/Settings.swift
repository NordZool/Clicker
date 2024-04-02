import Foundation

final class Settings : ObservableObject {
    //optimal range for this is from 70 to 180
    //used in GridItem and in .frame() modifier of ClickerView and TypeView
    @Published var itemSize: CGFloat = 80 {
        didSet {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(itemSize) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsKey_itemSize)
            }
        }
    }
    
    init() {
        //init data for 'itemSize' from UD
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey_itemSize) {
            let decoder = JSONDecoder()
            if let itemSize = try? decoder.decode(CGFloat.self, from: data) {
                self.itemSize = itemSize
            }
        }
    }
    
    //variable only for UD
    private let userDefaultsKey_itemSize = "ITEMSIZE"
}
