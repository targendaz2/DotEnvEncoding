//
//  DotEnvSingleValueEncodingContainer.swift
//  DotEnvEncoding
//
//  Created by David Rosenberg on 8/30/25.
//

import Foundation

final class DotEnvSingleValueEncodingContainer: SingleValueEncodingContainer {
    let encoder: DotEnvEncoder
    var codingPath: [any CodingKey] { encoder.codingPath }
    
    init(encoder: DotEnvEncoder) {
        self.encoder = encoder
    }
    
    func encodeNil() throws {
        // exclude nil values from dotenv files
        return
    }
    
    func encode<T: Encodable>(_ value: T) throws {
        let key = codingPath.map { $0.stringValue }.joined(separator: "_")
        
        switch value {
            case let value as Bool:
                encoder.addPair(key, value ? "true" : "")
            case let value as String:
                encoder.addPair(key, value)
            case let value as Double:
                encoder.addPair(key, String(value))
            case let value as Float:
                encoder.addPair(key, String(value))
            case let value as Int:
                encoder.addPair(key, String(value))
            case let value as Int8:
                encoder.addPair(key, String(value))
            case let value as Int16:
                encoder.addPair(key, String(value))
            case let value as Int32:
                encoder.addPair(key, String(value))
            case let value as Int64:
                encoder.addPair(key, String(value))
             case let value as Int128:
                 encoder.addPair(key, String(value))
            case let value as UInt:
                encoder.addPair(key, String(value))
            case let value as UInt8:
                encoder.addPair(key, String(value))
            case let value as UInt16:
                encoder.addPair(key, String(value))
            case let value as UInt32:
                encoder.addPair(key, String(value))
            case let value as UInt64:
                encoder.addPair(key, String(value))
             case let value as UInt128:
                 encoder.addPair(key, String(value))
            default:
                try value.encode(to: encoder)
        }
    }
}


