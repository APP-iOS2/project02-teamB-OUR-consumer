import Foundation
import FirebaseStorage
import FirebaseAuth
import Firebase

final class FeedStorageManager {
    
    static let shared = FeedStorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    
    
    //    func delete() async {
    //
    //        do{
    //            //try await print("딜리트 함수실행:::\(storage.child("FeedPosts").listAll())")
    //            try await storage.child("FeedPosts").delete()
    //        }catch {
    //            print(error.localizedDescription)
    //        }
    //    }
    //
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(id: String) -> StorageReference {
        storage.child("FeedPosts").child(id)
    }
    
    func getSavedImage(id: String, path: String) async throws -> Data {
        try await userReference(id: id).child(path).data(maxSize: 3 * 1024 * 1024)
    }
    
    func saveImage(data: Data, id: String) async throws -> URL {
      
//        metadata 삭제, return 타입 URL 만 받음
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        do {
            //파베에 사진 저장하기
            let _ = try await userReference(id: id).child(path).putDataAsync(data, metadata: nil)
            
            // 저장된 사진의 url 받아오기
            let test = try await userReference(id: id).child(path).downloadURL()
            // url 리턴하기
            return test
        } catch {
            throw StorageErrorCode.quotaExceeded
        }
        
        
    
//        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
//            throw URLError(.badURL)
//        }
        
//        return test
    }
    
    
    
}
