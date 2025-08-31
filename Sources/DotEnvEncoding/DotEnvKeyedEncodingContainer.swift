//
//  DotEnvKeyedEncodingContainer.swift
//  DotEnvEncoding
//
//  Created by David Rosenberg on 8/30/25.
//

import Foundation

final class DotEnvKeyedEncodingContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {
    typealias Key = Key
    
    let encoder: DotEnvEncoder
    var codingPath: [any CodingKey] { encoder.codingPath }
    
    init(encoder: DotEnvEncoder) {
        self.encoder = encoder
    }
    
    func encodeNil(forKey key: Key) throws {
        // exclude nil values from dotenv files
        return
    }
    
    func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        
            switch value {
                case let value as Bool:
                    encoder.addPair(key.stringValue, value ? "true" : "")
                case let value as String:
                    encoder.addPair(key.stringValue, escape(value))
                case let value as Double:
                    encoder.addPair(key.stringValue, String(value))
                case let value as Float:
                    encoder.addPair(key.stringValue, String(value))
                case let value as Int:
                    encoder.addPair(key.stringValue, String(value))
                case let value as Int8:
                    encoder.addPair(key.stringValue, String(value))
                case let value as Int16:
                    encoder.addPair(key.stringValue, String(value))
                case let value as Int32:
                    encoder.addPair(key.stringValue, String(value))
                case let value as Int64:
                    encoder.addPair(key.stringValue, String(value))
                 case let value as Int128:
                     encoder.addPair(key.stringValue, String(value))
                case let value as UInt:
                    encoder.addPair(key.stringValue, String(value))
                case let value as UInt8:
                    encoder.addPair(key.stringValue, String(value))
                case let value as UInt16:
                    encoder.addPair(key.stringValue, String(value))
                case let value as UInt32:
                    encoder.addPair(key.stringValue, String(value))
                case let value as UInt64:
                    encoder.addPair(key.stringValue, String(value))
                 case let value as UInt128:
                     encoder.addPair(key.stringValue, String(value))
                default:
                    try value.encode(to: encoder)
            }
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key)
    -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey
    {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        return encoder.container(keyedBy: keyType)
    }
    
    func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
        encoder.codingPath.append(key)
        defer { encoder.codingPath.removeLast() }
        return encoder.unkeyedContainer()
    }
    
    func superEncoder() -> any Encoder {
        encoder
    }
    
    func superEncoder(forKey key: Key) -> any Encoder {
        encoder
    }
}
