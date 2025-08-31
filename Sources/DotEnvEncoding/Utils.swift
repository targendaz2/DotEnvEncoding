//
//  Utils.swift
//  DotEnvEncoding
//
//  Created by David Rosenberg on 8/30/25.
//

import Foundation

func escape(_ value: String) -> String {
    if value.rangeOfCharacter(from: .whitespaces) != nil {
        let escaped = value.replacingOccurrences(of: "\"", with: "\\\"")
        return "\"\(escaped)\""
    }
    return value
}
