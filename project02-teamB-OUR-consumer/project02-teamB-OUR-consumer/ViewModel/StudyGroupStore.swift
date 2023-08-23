//
//  StudyGroupStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 안지영 on 2023/08/23.
//

import Foundation
import FirebaseFirestore

class StudyGroupStore: ObservableObject {
    
    @Published var studyArray: [Study] = []
    
    
    func fetchStudy() {
        Firestore.firestore().collection("StudyGroup")
        
    }

    
    func sortedStudy() -> [Study] {
        let sortedArray = studyArray.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    func sortedOnlineStudy() -> [Study] {
        let sortedArray = studyArray.filter { $0.isOnline }.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    func sortedOfflineStudy() -> [Study] {
        let sortedArray = studyArray.filter { !$0.isOnline }.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
}
