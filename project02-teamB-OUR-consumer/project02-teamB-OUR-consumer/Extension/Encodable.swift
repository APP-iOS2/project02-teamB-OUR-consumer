//
//  Encodable.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/23.
//

import Foundation
import Firebase


enum CustomError: Error{
    case decodingError
}

extension Encodable {
    
    /// Object to Dictionary
    /// cf) Dictionary to Object: JSONDecoder().decode(Object.self, from: dictionary)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictinoary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictinoary
    }
}


extension Dictionary where Key == String{
    
    func decodeTo<T>(_ type: T.Type) -> T? where T: Decodable {
        var dict = self
        
        dict.filter {
            $0.value is Date || $0.value is Timestamp
        }.forEach {
            if $0.value is Date {
                let date = $0.value as? Date ?? Date()
                dict[$0.key] = date as? Value
            } else if $0.value is Timestamp {
                let date = $0.value as? Timestamp ?? Timestamp()
                dict[$0.key] = date.dateValue().toString() as? Value
            }
        }
        
        let jsonData = (try? JSONSerialization.data(withJSONObject: dict, options: [])) ?? nil
        
        if let jsonData {
            return (try? JSONDecoder().decode(type, from: jsonData)) ?? nil
        } else {
            return nil
        }
    }
}
