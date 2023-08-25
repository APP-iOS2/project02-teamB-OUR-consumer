import Foundation
import Firebase

class DatabaseService {
    
    private var db = Firestore.firestore()
    
    func fetchResume(for userId: String, completion: @escaping (Result<Resume, Error>) -> Void) {
        fetchDocument(from: "resumes", withField: "userId", equalTo: userId, completion: completion)
    }
    
    func saveResume(resume: Resume, completion: @escaping (Error?) -> Void) {
        do {
            let _ = try db.collection("resumes").addDocument(from: resume)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func fetchUser(for documentId: String, completion: @escaping (Result<User, Error>) -> Void) {
        let docRef = Firestore.firestore().collection("users").document(documentId)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let document = document, document.exists, let user = try? document.data(as: User.self) {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document doesn't exist"])))
            }
        }
    }
    
    /*
     패치 함수 공통 부분 분리
     */
    private func fetchDocument<T: Decodable>(from collection: String, withField field: String, equalTo value: String, completion: @escaping (Result<T, Error>) -> Void) {
        let query = db.collection(collection).whereField(field, isEqualTo: value)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let document = querySnapshot?.documents.first {
                do {
                    let dataObject = try document.data(as: T.self)
                    completion(.success(dataObject))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            } else {
                completion(.failure(NSError(domain: "com.yourApp", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found for \(field) \(value)"])))
            }
        }
    }
}
