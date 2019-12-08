import Foundation

extension JSONDecoder {
    func decode<T>(_ type: T.Type, from json: [String: Any]) throws -> T where T: Decodable {
        return try decode(type, from: try JSONSerialization.data(withJSONObject: json, options: []))
    }
    
    func decode<T>(_ type: T.Type, from jsonArray: [Any]) throws -> T where T: Decodable {
        return try decode(type, from: try JSONSerialization.data(withJSONObject: jsonArray, options: []))
    }
}
