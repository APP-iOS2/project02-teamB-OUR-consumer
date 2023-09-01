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
    
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let date: Date = dateFormatter.date(from: self) else {return Date()}
        return date
    }
    
    func toDateWithSlash() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm a"
        guard let date: Date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
    
    func stringToUUID() -> UUID? {
        return UUID(uuidString: self)
    }
}

// MARK: Firebase collection 목록
extension String {
    static var users: String {
        return "users"
    }
    
    static var studyGroup: String {
        return "studyGroup"
    }
    
    static var studyComments: String {
        return "comments"
    }
}

extension String {
    
    func compareDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일 HH:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR") // 날짜 포맷에 맞는 로케일 설정

        if let date = dateFormatter.date(from: "23년 09월 01일 00:40") {
            return date
        } else {
            return Date()
        }
    }
    
}
