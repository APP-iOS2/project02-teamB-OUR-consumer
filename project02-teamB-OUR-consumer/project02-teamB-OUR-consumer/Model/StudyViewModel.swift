//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

class StudyViewModel: ObservableObject {
    let dbRef = Firestore.firestore().collection("StudyGroup")
    @Published var studyArray: [Study] = []
    
    func fetchStudy() {
        dbRef.getDocuments { (snapshot, error) in
            self.studyArray.removeAll()
            
            if let snapshot {
                var temp: [Study] = []
                for document in snapshot.documents {
                    
                }
                
                temp
            }
        }
        
    }

}
