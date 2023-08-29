import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Resume: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var introduction: String?
    var workExperience: [WorkExperience]
    var education: [Education]
    var skills: [Skill]
    var projects: [Project]
}

struct WorkExperience: Identifiable, Codable {
    var id: String = UUID().uuidString
    var jobTitle: String
    var company: Company
    var startDate: Date
    var endDate: Date
    var description: String?
    
    var startDateString: String {
        return formatDate(startDate)
    }
    
    var endDateString: String {
        return formatDate(endDate)
    }
    
    func formatDate(_ date: Date) -> String {
       let formatter = DateFormatter()
       formatter.locale = Locale(identifier: "ko_KR")
       formatter.dateFormat = "yy년 M월 dd일 HH:mm"
       return formatter.string(from: date)
   }
}

struct Education: Identifiable, Codable {
    var id: String = UUID().uuidString
    var schoolName: String
    var degree: String
    var fieldOfStudy: String
    var startDate: Date
    var endDate: Date?
    var description: String?
}

struct Project: Identifiable, Codable {
    var id: String = UUID().uuidString
    var projectTitle: String
    var jobTitle: String
    var startDate: Date
    var endDate: Date?
    var description: String?
}

struct Skill: Identifiable, Codable {
    var id: String = UUID().uuidString
    var skillName: String
    var description: String?
}

struct Company: Codable {
    var companyName: String
    let companyImage: String?
}
