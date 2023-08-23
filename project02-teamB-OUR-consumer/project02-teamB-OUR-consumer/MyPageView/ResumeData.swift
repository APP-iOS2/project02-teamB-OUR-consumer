//
//  ResumeData.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import Foundation

struct User: Identifiable {
    let id: UUID = UUID()
    let name: String
    let email: String
    let profileImage: String?
    let profileMessage: String?
}

struct Resume: Identifiable {
    let id: UUID = UUID()
    let userId: UUID
    let introduction: String?
    let workExperience: [WorkExperience]
    let education: [Education]
    let skills: [Skill]
    let projects: [Project]
}

struct WorkExperience: Identifiable {
    let id: UUID = UUID()
    let jobTitle: String
    let company: Company
    //    let startDate: Date
    //    let endDate: Date?
    var startDate: Double
    var endDate: Double
    let description: String?
    
    var startDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월"
        
        let dateCreatedAt = Date(timeIntervalSince1970: startDate)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
    var endDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월"
        
        let dateCreatedAt = Date(timeIntervalSince1970: endDate)
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
}

struct Education: Identifiable {
    let id: UUID = UUID()
    let schoolName: String
    let degree: String
    let fieldOfStudy: String
    let startDate: Date
    let endDate: Date?
    let description: String?
}

struct Project: Identifiable {
    let id: UUID = UUID()
    let projectTitle: String
    let jobTitle: String
    let startDate: Date
    let endDate: Date?
    let description: String?
}

struct Skill: Identifiable {
    let id: UUID = UUID()
    let skillName: String
    let description: String?
}

struct Company {
    let companyName: String
    let companyImage: String?
}
