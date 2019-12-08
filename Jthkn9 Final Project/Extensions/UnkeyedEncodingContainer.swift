extension UnkeyedEncodingContainer {
    mutating func encode(_ value: Array<Any>) throws {
        try value.enumerated().forEach({ (index, value) in
            switch value {
            case let value as Bool:
                try encode(value)
            case let value as Int:
                try encode(value)
            case let value as String:
                try encode(value)
            case let value as Double:
                try encode(value)
            case let value as Dictionary<String, Any>:
                try encode(value)
            case let value as Array<Any>:
                var container = nestedUnkeyedContainer()
                try container.encode(value)
            case Optional<Any>.none:
                try encodeNil()
            case let value as Encodable:
                try value.encode(to: superEncoder())
            default:
                let key = JsonCodingKey(intValue: index)
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + [key], debugDescription: "Invalid JSON value"))
            }
        })
    }
    
    mutating func encode(_ value: Dictionary<String, Any>) throws {
        var nestedContainer = self.nestedContainer(keyedBy: JsonCodingKey.self)
        try nestedContainer.encode(value)
    }
}
