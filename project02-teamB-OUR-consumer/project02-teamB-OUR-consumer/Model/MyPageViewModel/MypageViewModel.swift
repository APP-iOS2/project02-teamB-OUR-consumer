import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MypageViewModel: ObservableObject {
    
    @Published var resume: Resume? = nil
    @Published var user: User? = nil
    private var db: DatabaseService
    
    init(db: DatabaseService, userId: String) {
        self.db = db
        loadUser(for: userId)
        loadResume(for: userId)
    }
    
    func loadUser(for userId: String) {
        db.fetchUser(for: userId) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print("Failed to load user: \(error.localizedDescription)")
            }
        }
    }
    
    func loadResume(for userId: String) {
        db.fetchResume(for: userId) { result in
            switch result {
            case .success(let resume):
                self.resume = resume
            case .failure(let error):
                print("Failed to load resume: \(error.localizedDescription)")
            }
        }
    }
    
    func saveResume(resume: Resume) {
        db.saveResume(resume: resume) { error in
            if let error = error {
                print("Failed to save resume: \(error.localizedDescription)")
            } else {
                print("Successfully saved resume!")
            }
        }
    }
}



//class ResumeStore: ObservableObject {
//    @Published var resume: Resume
//    var sampleDescription: String = "Lorem ipsum dolor sit amet consectetur. Magna dictum velit tempus ut. Semper aliquet morbi egestas tempus aliquam cursus viverra feugiat. Ultrices massa dictum massa nulla iaculis amet. At malesuada massa mattis sed lobortis vel."
//
//    init() {
//        resume = Resume(userId: "xvIqCPU4EhHOhxVG7PUN",
//                        introduction: sampleDescription,
//                        workExperience: [WorkExperience(jobTitle: "iOS 개발자",
//                                                        company: Company(companyName: "Netflix", companyImage: "CompanyImageSample"),
//                                                        startDate: Date().timeIntervalSince1970,
//                                                        endDate: Date().timeIntervalSince1970,
//                                                        description: sampleDescription)],
//                        education: [],
//                        skills: [],
//                        projects: [])
//    }
//}
