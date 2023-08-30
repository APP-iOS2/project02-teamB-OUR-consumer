//
//  AnnounceStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김종찬 on 2023/08/30.
//

import Foundation
import FirebaseFirestore

class AnnouncementStore: ObservableObject {
    @Published var announcementArr: [Announcement] = []
    
    let deRef = Firestore.firestore().collection("Announcement")
    
    func fetch() {
        
        deRef.getDocuments { (snapshot, error) in
            self.announcementArr.removeAll()
            
            if let snapshot {
                var tempArr: [Announcement] = []
                
                for document in snapshot.documents {
                    let id: String = document.documentID
                    let docData: [String: Any] = document.data()
                    
                    let category: String = docData["category"] as? String ?? ""
                    let title: String = docData["title"] as? String ?? ""
                    let context: String = docData["context"] as? String ?? ""
                    let createdAt: Double = docData["createdAt"] as? Double ?? Date().timeIntervalSince1970
                    
                    let announce: Announcement = Announcement(id: id, title: title, context: context, createdAt: createdAt, category: category)
                    
                    tempArr.append(announce)
                }
                self.announcementArr = tempArr
                self.sortAnnouncement()
            }
        }
    }
    
    func sortAnnouncement() {
        announcementArr.sort(by: { $0.createdAt > $1.createdAt } )
    }
}
