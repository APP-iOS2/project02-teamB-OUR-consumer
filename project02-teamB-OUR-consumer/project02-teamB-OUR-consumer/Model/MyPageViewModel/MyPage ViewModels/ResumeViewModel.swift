import Foundation
import Firebase

class ResumeViewModel: ObservableObject {
    @Published var resume: Resume?
    private var db = Firestore.firestore()
    
    // Read
    func fetchResume(userId: String) {
        db.collection("resumes").whereField("userId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let snapshot = snapshot, !snapshot.isEmpty, let document = snapshot.documents.first {
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
    func updateResume(resume: Resume) {
        if let resumeId = resume.id {
            do {
                try db.collection("resumes").document(resumeId).setData(from: resume)
            } catch let error {
                print("Error updating resume: \(error)")
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

extension ResumeViewModel {
    func updateProject(collectionName: String, documentID: String, fieldName: String, newValue: Any) {
        let db = Firestore.firestore()
        let docRef = db.collection("resumes").document(documentID)
        
        docRef.updateData([
            fieldName: newValue
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
