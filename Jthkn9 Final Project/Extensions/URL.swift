import Foundation

extension URL {
    var baseName: String {
        return lastPathComponent.components(separatedBy: ".").dropLast().joined()
    }
}
