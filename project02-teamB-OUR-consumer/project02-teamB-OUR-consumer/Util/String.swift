//
//  String.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import Foundation


extension String {
    func tokenize(_ delimiters: String) -> [String] {
        var output = [String]()
        var buffer = ""
        for char in self {
            if delimiters.contains(char) {
                print(buffer)
                output.append(buffer)
                buffer = String(char)
            } else {
                buffer += String(char)
            }
        }
        output.append(buffer)
        return output
    }
}
