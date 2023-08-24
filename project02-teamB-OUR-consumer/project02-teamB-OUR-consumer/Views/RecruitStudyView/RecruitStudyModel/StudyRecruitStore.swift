//
//  AddRecruitStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class StudyRecruitStore: ObservableObject {
    
    @Published var studyStores: [StudyRecruitModel] = []
    
    let dbRef = Firestore.firestore().collection("StudyPosts")
    
    func fetchFeeds() {
        
        dbRef.getDocuments { (snapshot, error) in
            
            self.studyStores.removeAll()
            
            if let snapshot {
                var tempStudys: [StudyRecruitModel] = []
                
                for document in snapshot.documents {

                    
                    let id: String = document.documentID
                    let docData: [String: Any] = document.data()
                    let creator: String = docData["creator"] as? String ?? ""
                    let studyTitle: String = docData["studyTitle"] as? String ?? ""

                    let description: String = docData["description"] as? String ?? ""
                    let isOnline: Bool = docData["isOnline"] as? Bool ?? false
                    let isOffline: Bool = docData["isOffline"] as? Bool ?? false
                    
                    let imageURL: [String] = docData["imageURL"] as? [String] ?? []
                    let locationName: String = docData["locationName"] as? String ?? ""
                    let reportCount: Int  = docData["reportCount"] as? Int ?? 0
              
                    let startAt: Date = docData["startAt"] as? Date ?? Date()
                    let dueAt: Date = docData["dueAt"] as? Date ?? Date()
                    
                    let studys = StudyRecruitModel(id: id, creator: creator, studyTitle: studyTitle, startAt: startAt, dueAt: dueAt, description: description, isOnline: isOnline, isOffline: isOffline, imageURL: imageURL, locationName: locationName, reportCount: reportCount)
                    tempStudys.append(studys)
                }
                
                self.studyStores  = tempStudys
            }
        }
    }
    
    func addFeed(_ study: StudyRecruitModel) {

        dbRef.document(study.id)
            .setData(["creator": study.creator,
                      "description": study.description,
                      "imageURL": study.imageURL,
                      "locationName": study.locationName,
                      "isOnline": study.isOnline,
                      "isOffline": study.isOffline,
                      "startAt": study.startAt,
                      "dueAt": study.dueAt,
                      "studyTitle": study.studyTitle,
                      "reportCount": study.reportCount])
        
        fetchFeeds()
    }

    
    func removeFeed(_ study: StudyRecruitModel) {
        
        dbRef.document(study.id).delete()
        
        fetchFeeds()
    }
    
    
    
}
