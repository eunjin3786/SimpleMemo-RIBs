
import Foundation

struct Memo {
    let ID: String
    var title: String

    init(title: String) {
        self.ID = ""
        self.title = title
    }
    
    init?(dic: [String: Any], ID: String) {
        guard let title = dic["title"] as? String else {
            return nil
        }
        
        self.ID = ID
        self.title = title
    }
}

extension Memo {
    func toDictionary() -> [String: Any] {
        return ["title": title]
    }
}
