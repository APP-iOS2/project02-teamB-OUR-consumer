//
//  StorageManager.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/25.
//

import Foundation
import FirebaseStorage
import FirebaseAuth
import Firebase

final class StorageManger {
    
    static let shared = StorageManger()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(id: String) -> StorageReference {
        storage.child("StudyPosts").child(id)
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
