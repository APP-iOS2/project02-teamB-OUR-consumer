import Foundation
import FirebaseStorage
import FirebaseAuth
import Firebase

final class FeedStorageManager {
    
    static let shared = FeedStorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(id: String) -> StorageReference {
        storage.child("FeedPosts").child(id)
    }
    
    func getSavedImage(id: String, path: String) async throws -> Data {
        try await userReference(id: id).child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func saveImage(data: Data, id: String) async throws -> (path: String, name: String, url: URL) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(id: id).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badURL)
        }

        let test = try await userReference(id: id).child(path).downloadURL()
        
        return (returnedPath, returnedName, test)
    }
    
    
    
}
