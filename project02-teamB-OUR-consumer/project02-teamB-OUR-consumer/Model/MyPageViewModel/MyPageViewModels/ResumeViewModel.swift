import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ResumeViewModel: ObservableObject {
    @Published var resume: Resume?
    private var db = Firestore.firestore()
    
    // Read
    func fetchResume(userId: String) {
        db.collection("resumes").whereField("userId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot, snapshot.isEmpty {
                self.createResume(
                    resume: Resume(userId: userId, workExperience: [], education: [], skills: [], projects: [])
                )
            }
            
            if let snapshot = snapshot, let document = snapshot.documents.first {
                let result = Result {
                    try document.data(as: Resume.self)
                }
                switch result {
                    case .success(let resume):
                        self.resume = resume
                    
                    case .failure(let error):
                        print("Error decoding resume: \(error)")
                }
            }
        }
        
    }
    
    // Create
    func createResume(resume: Resume) {
        do {
            let _ = try db.collection("resumes").addDocument(from: resume)
        } catch let error {
            print("Error creating resume: \(error)")
        }
    }
    
    // Update
    func updateResume(resume: Resume? = nil) {
        if let resume = resume {
            if let resumeId = resume.id {
                do {
                    try db.collection("resumes").document(resumeId).setData(from: resume)
                    self.resume = resume
                } catch let error {
                    print("Error updating resume: \(error)")
                }
            }
        } else {
            if let resume = self.resume {
                do {
                    let resumeId = resume.id!
                    try db.collection("resumes").document(resumeId).setData(from: resume)
                    self.resume = resume
                } catch let error {
                    print("Error updating resume: \(error)")
                }
            }
        }
    }
    
    // Delete
    func deleteResume(resumeId: String) {
        db.collection("resumes").document(resumeId).delete { error in
            if let error = error {
                print("Error deleting resume: \(error)")
            }
        }
    }
}

