//
//  UserData.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/23.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    let id: UUID = UUID()
    let name: String
    let email: String
    let profileImage: String
    let profileMessage: String?
}

struct StudyGroupComment: Identifiable {
    var id: UUID = UUID()
    var userId: String // 이것도 포스트아이디처럼 따로 받아와야되나?!
    var profileString: String?
    var content: String
    var createdAt: Double = Date().timeIntervalSince1970
    
    var profileImage: Image {
        Image(profileString ?? "OUR_Logo")
    }
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
}




struct studyCommentReport: Identifiable {
    var id: UUID = UUID()
    var userId: String
    var reportContent: String
    var reportCategory: String
}
