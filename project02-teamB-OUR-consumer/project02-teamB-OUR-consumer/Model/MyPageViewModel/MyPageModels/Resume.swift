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
    let jobTitle: String
    let company: Company
    var startDate: Double
    var endDate: Double
    let description: String?
    
    var startDateString: String {
        return formatDate(from: startDate)
    }
    
    var endDateString: String {
        return formatDate(from: endDate)
    }
    
    private func formatDate(from timestamp: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월"
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}

struct Education: Identifiable, Codable {
    var id: String = UUID().uuidString
    let schoolName: String
    let degree: String
    let fieldOfStudy: String
    let startDate: Date
    let endDate: Date?
    let description: String?
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
    let skillName: String
    let description: String?
}

struct Company: Codable {
    let companyName: String
    let companyImage: String?
}
