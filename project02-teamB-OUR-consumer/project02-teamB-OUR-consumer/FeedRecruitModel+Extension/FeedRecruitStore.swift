//
//  FeedRecruitStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FeedRecruitStore: ObservableObject {
    
    
    @Published var feedStores: [FeedRecruitModel] = []
    
    let dbRef = Firestore.firestore().collection("posts")
    
    func fetchFeeds() {
        
        dbRef.getDocuments { (snapshot, error) in
            
            self.feedStores.removeAll()
            
            if let snapshot {
                var tempFeeds: [FeedRecruitModel] = []
                
                for document in snapshot.documents {
                    let id: String = document.documentID
                    let docData: [String: Any] = document.data()
                    let creator: String = docData["creator"] as? String ?? ""
                    let content: String = docData["content"] as? String ?? ""
                    let imageURL: [String] = docData["imageString"] as? [String] ?? []
                    let location: String = docData["location"] as? String ?? ""
                    let privateSetting: Bool = docData["privateSetting"] as? Bool ?? false
                    let createdAt: Double = docData["createdDate"] as? Double ?? 0.0
                    let reportCount: Int  = docData["reportCount"] as? Int ?? 0
                    
                    let feeds = FeedRecruitModel(id: id, creator: creator, content: content, imageURL: imageURL, location: location, privateSetting: privateSetting, reportCount: reportCount , createdAt: createdAt)
                    
                    tempFeeds.append(feeds)
                }
                
                self.feedStores  = tempFeeds
            }
        }
    }
    
    
    func addFeed(_ feed: FeedRecruitModel) {

        dbRef.document(feed.id)
            .setData(["creator": feed.creator,
                      "content": feed.content,
                      "imageString": feed.imageURL,
                      "location": feed.location,
                      "privateSetting": feed.privateSetting,
                      "createdAt": feed.createdDate,
                      "reportCount": feed.reportCount])
        
        fetchFeeds()
    }

    
    func removeFeed(_ feed: FeedRecruitModel) {
        
        dbRef.document(feed.id).delete()
        
        fetchFeeds()
    }
    
    
}
