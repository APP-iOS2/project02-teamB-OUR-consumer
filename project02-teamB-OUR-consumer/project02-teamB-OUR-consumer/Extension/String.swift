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
                output.append(buffer)
                buffer = String(char)
            } else {
                buffer += String(char)
            }
        }
        output.append(buffer)
        return output
    }
    
    
    func toDate() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let date: Date = dateFormatter.date(from: self) else {return Date()}
        return date
    }
}
