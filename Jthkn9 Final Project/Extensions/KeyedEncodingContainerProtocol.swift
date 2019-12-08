extension KeyedEncodingContainerProtocol {
    mutating func encode(_ value: Dictionary<String, Any>?, forKey key: Key) throws {
        if value != nil {
            var container = self.nestedContainer(keyedBy: JsonCodingKey.self, forKey: key)
            try container.encode(value!)
        }
    }
    
    mutating func encodeIfPresent(_ value: Dictionary<String, Any>?, forKey key: Key) throws {
        if let value = value {
            try encode(value, forKey: key)
        }
    }
    
    mutating func encode(_ value: Array<Any>?, forKey key: Key) throws {
        if value != nil {
            var container = self.nestedUnkeyedContainer(forKey: key)
            try container.encode(value!)
        }
    }
    
    mutating func encodeIfPresent(_ value: Array<Any>?, forKey key: Key) throws {
        if let value = value {
            try encode(value, forKey: key)
        }
    }
}

extension KeyedEncodingContainerProtocol where Key == JsonCodingKey {
    mutating func encode(_ value: Dictionary<String, Any>) throws {
        try value.forEach({ (key, value) in
            let key = JsonCodingKey(stringValue: key)
            switch value {
            case let value as Bool:
                try encode(value, forKey: key)
            case let value as Int:
                try encode(value, forKey: key)
            case let value as String:
                try encode(value, forKey: key)
            case let value as Double:
                try encode(value, forKey: key)
            case let value as Dictionary<String, Any>:
                try encode(value, forKey: key)
            case let value as Array<Any>:
                try encode(value, forKey: key)
            case Optional<Any>.none:
                try encodeNil(forKey: key)
            case let value as Encodable:
                try value.encode(to: superEncoder())
            default:
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + [key], debugDescription: "Invalid JSON value"))
            }
        })
    }
}
