extension UnkeyedDecodingContainer {
    mutating func decode(_ type: Array<Any>.Type, deep: Bool = false) throws -> Array<Any> {
        var array: [Any] = []
        
        var container = deep ? try self.nestedUnkeyedContainer() : self
        
        while container.isAtEnd == false {
            // See if the current value in the JSON array is `null` first and prevent infite recursion with nested arrays.
            if try container.decodeNil() {
                continue
            } else if let value = try? container.decode(Bool.self) {
                array.append(value)
                // Why is this missing? The guess is Double will work for both Int and Double and there is no knowing which is intended.
                //            } else if let value = try? container.decode(Int.self) {
                //                array.append(value)
            } else if let value = try? container.decode(Double.self) {
                array.append(value)
            } else if let value = try? container.decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? container.decode(Dictionary<String, Any>.self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? container.decode(Array<Any>.self, deep: true) {
                array.append(nestedArray)
            } else {
                let _ = try container.decode(AnyCodable.self)
            }
        }
        return array
    }
    
    mutating func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        let nestedContainer = try self.nestedContainer(keyedBy: JsonCodingKey.self)
        return try nestedContainer.decode(type)
    }
}
