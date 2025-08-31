//
//  DotEnvUnkeyedEncodingContainer.swift
//  DotEnvEncoding
//
//  Created by David Rosenberg on 8/30/25.
//

import Foundation

final class DotEnvUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    let encoder: DotEnvEncoder
    var codingPath: [any CodingKey] { encoder.codingPath }
    let count = 0
    
    var values: [String] = []
    
    init(encoder: DotEnvEncoder) {
        self.encoder = encoder
    }
    
    deinit {
        if values.isEmpty {
            return
        }
        
        let key = codingPath.map { $0.stringValue }.joined(separator: "_")
        
        let separator: String
        if encoder.arraySeparators.keys.contains(key) {
            separator = encoder.arraySeparators[key]!
        } else {
            separator = encoder.defaultArraySeparator
        }
        
        encoder.addPair(key, values.joined(separator: separator))
    }
    
    func encodeNil() throws {
        // exclude nil values from dotenv files
        return
    }
    
    func encode<T: Encodable>(_ value: T) throws {
        switch value {
            case let value as Bool:
                values.append(value ? "true" : "")
            case let value as String:
                values.append(escape(value))
            case let value as Double:
                values.append(String(value))
            case let value as Float:
                values.append(String(value))
            case let value as Int:
                values.append(String(value))
            case let value as Int8:
                values.append(String(value))
            case let value as Int16:
                values.append(String(value))
            case let value as Int32:
                values.append(String(value))
            case let value as Int64:
                values.append(String(value))
             case let value as Int128:
                 values.append(String(value))
            case let value as UInt:
                values.append(String(value))
            case let value as UInt8:
                values.append(String(value))
            case let value as UInt16:
                values.append(String(value))
            case let value as UInt32:
                values.append(String(value))
            case let value as UInt64:
                values.append(String(value))
             case let value as UInt128:
                 values.append(String(value))
            default:
                try value.encode(to: encoder)
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type)
    -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    {
        encoder.container(keyedBy: keyType)
    }
    
    func nestedUnkeyedContainer() -> any UnkeyedEncodingContainer {
        self
    }
    
    func superEncoder() -> any Encoder {
        encoder
    }
}
