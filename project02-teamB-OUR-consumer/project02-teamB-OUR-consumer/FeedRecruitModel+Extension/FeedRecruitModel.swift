//
//  FeedRecruitModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/23.
//

import Foundation
import SwiftUI

struct FeedRecruitModel {
    
    var id: String = UUID().uuidString
    var creator: String
    var content: String
    var imageURL: [String]
    var location: String
    var privateSetting: Bool
    var createdAt: Double = Date().timeIntervalSince1970
    
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return dateFormatter.string(from: dateCreatedAt)
    }

}
