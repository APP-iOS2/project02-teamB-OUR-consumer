//
//  FeedRecruitModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct FeedRecruitModel: Codable, Identifiable {
    
    //    var id: String = UUID().uuidString
    @DocumentID var id: String?
    var creator: String?
    var content: String?
    var location: String?
    var privateSetting: Bool?
    var reportCount: Int?
    
    var createdAt: String?
    var postImagePath: [String]
    
    
    //    var createdDate: String {
    //        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
    //
    //        let dateFormatter: DateFormatter = DateFormatter()
    //        dateFormatter.locale = Locale(identifier: "ko-KR")
    //        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
    //        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    //
    //        return dateFormatter.string(from: dateCreatedAt)
    //    }
    
}


enum PrivacySetting {
    
    case Public
    case Private
    
    // 각 case에 맞게 가격을 화면에 보여주기 위해
    var setting: Bool {
        switch self {
        case .Public:
            return false
        case .Private:
            return true
        }
    }
}
