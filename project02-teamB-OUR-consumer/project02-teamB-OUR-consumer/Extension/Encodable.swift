//
//  Encodable.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/23.
//

import Foundation


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
    
    func toDTO() throws -> NotificationDTO{
        do{
            let json = try JSONSerialization.data(withJSONObject: self, options: [.fragmentsAllowed])
            let dto = try JSONDecoder().decode(NotificationDTO.self, from: json)
            return dto
        }catch{
            throw CustomError.decodingError
        }
    }
}
