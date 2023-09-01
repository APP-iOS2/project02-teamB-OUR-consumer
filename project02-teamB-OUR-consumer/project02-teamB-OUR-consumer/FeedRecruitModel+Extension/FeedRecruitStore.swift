//
//  FeedRecruitStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import PhotosUI
import _PhotosUI_SwiftUI

class FeedRecruitStore: ObservableObject {
    let service = RecruitService()
    
    @Published var feedStores: [FeedRecruitModel] = []
    
    let dbRef = Firestore.firestore().collection("posts")
    
    func fetchFeeds() {
        
        service.fetchAll(collection: .posts) { results in
            self.feedStores = results
        }
    }
    
    func addFeed( _ data: FeedRecruitModel ) {
        service.add(collection: .posts, data: data)
    }
    
    
    func updateData( docID: String, _ data: FeedRecruitModel ) {
        service.update(collection: .posts, documentID: docID, data: data)
    }
    
    //이미지 FireBase Storage에 Save.
    
    
    
    func returnImagePath(items: [PhotosPickerItem]) async throws -> [String]{
        
        var urlString:[String] = []
        
        for item in items {
            
            guard let data = try? await item.loadTransferable(type: Data.self) else {return urlString}
            print("원래데이터 크기:\(data.count)")
            
            guard let uiImage = UIImage(data: data) else {return urlString}
            guard let compressImage = uiImage.jpegData(compressionQuality: 0.5) else {return urlString}
            print("변형된 데이터 크기:\(compressImage.count)")
            
            do {
                
                let (_, _, url) = try await FeedStorageManager.shared.saveImage(data: compressImage, id: dbRef.document().documentID)
                
                urlString.append(url.absoluteString)
            } catch {
                print("리턴이미지패스\(error.localizedDescription)")
            }
            
        }
        
        return urlString
    }
    
    func saveStudyImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name, url) = try await FeedStorageManager.shared.saveImage(data: data, id: dbRef.document().documentID)
            print("SUCCESS!!!!")
            print("path : \(path)")
            print("name : \(name)")
            print("url : \(url)")
        }
    }
    
}
