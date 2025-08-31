//
//  File.swift
//  DotEnvEncoding
//
//  Created by David Rosenberg on 8/30/25.
//

import Foundation

public class DotEnvEncoder: Encoder {
    public var codingPath: [any CodingKey] = []
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    
    var keyValues: [String: String] = [:]
    var defaultArraySeparator: String
    var arraySeparators: [String : String]
    
    public init(
        defaultArraySeparator: String = " ",
        arraySeparators: [String : String] = [:]
    ) {
        self.defaultArraySeparator = defaultArraySeparator
        self.arraySeparators = arraySeparators
    }
    
    public func encode<T: Encodable>(_ value: T) throws -> String {
        try value.encode(to: self)
        return keyValues.map { "\($0.key)=\($0.value)" }.joined(separator: "\n")
    }
    
    func addPair(_ key: String, _ value: String) {
        self.keyValues[key] = value
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key>
    where Key: CodingKey {
        KeyedEncodingContainer(DotEnvKeyedEncodingContainer(encoder: self))
    }
    
    public func unkeyedContainer() -> any UnkeyedEncodingContainer {
        DotEnvUnkeyedEncodingContainer(encoder: self)
    }
    
    public func singleValueContainer() -> any SingleValueEncodingContainer {
        DotEnvSingleValueEncodingContainer(encoder: self)
    }
}
