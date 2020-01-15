import Foundation

extension String {
    func removeSpecialCharacters() -> String {
        return self.components(separatedBy: CharacterSet.letters.inverted).joined()
    }
}
