//
//  AddRecruitStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import PhotosUI




class StudyRecruitStore: ObservableObject {
    @Published var studyStores: [StudyRecruitModel] = []
    @State var returnUrlTest: String = ""
    
    
    let service = RecruitService()
//    private let userCollection = Firestore.firestore().collection("StudyPosts")
//
    let dbRef = Firestore.firestore().collection("StudyPosts")
    
    
    
    func fetchFeeds() {

        service.fetchAll(collection: .studypost) { results in
            self.studyStores = results
        }
    }
    
    func addFeed(_ study: StudyRecruitModel) {
        service.add(collection: .studypost, data: study)
    }
    
    func removeFeed(_ study: StudyRecruitModel) {
        let docID = study.id ?? ""
        service.remove(collection: .studypost, documentID: docID)
    }
    
//    func fetchFeeds() {
//        dbRef.getDocuments { (snapshot, error) in
//            self.studyStores.removeAll()
//
//            if let snapshot {
//                var tempStudys: [StudyRecruitModel] = []
//
//                for document in snapshot.documents {
//                    let id: String = document.documentID
//                    let docData: [String: Any] = document.data()
//                    let creator: String = docData["creator"] as? String ?? ""
//                    let studyTitle: String = docData["studyTitle"] as? String ?? ""
//                    let description: String = docData["description"] as? String ?? ""
//                    let isOnline: Bool = docData["isOnline"] as? Bool ?? false
//                    let isOffline: Bool = docData["isOffline"] as? Bool ?? false
//                    let locationName: String = docData["locationName"] as? String ?? ""
//                    let reportCount: Int  = docData["reportCount"] as? Int ?? 0
//                    let startAt: String = docData["startAt"] as? String ?? ""
//                    let dueAt: String = docData["dueAt"] as? String ?? ""
//                    let studyImagePath: [String] = docData["studyImagePath"] as? [String] ?? []
//                    let studyCount: Int = docData["studyCount"] as? Int ?? 1
//                    let studyCoordinates: [Double] = docData["studyCoordinates"] as? [Double] ?? []
//
//                    let studys = StudyRecruitModel(id: id, creator: creator, studyTitle: studyTitle, startAt: startAt, dueAt: dueAt, description: description, isOnline: isOnline, isOffline: isOffline, locationName: locationName, reportCount: reportCount, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: studyCoordinates)
//
//                    tempStudys.append(studys)
//                }
//                self.studyStores  = tempStudys
//            }
//        }
//    }
//
//    func addFeed(_ study: StudyRecruitModel) {
//
//        dbRef.document(study.id ?? "abcTest")
//            .setData([
//                "id": study.id,
//                "creator": study.creator,
//                "description": study.description,
//                "locationName": study.locationName,
//                "isOnline": study.isOnline,
//                "isOffline": study.isOffline,
//                "startAt": study.startAt,
//                "dueAt": study.dueAt,
//                "studyTitle": study.studyTitle,
//                "reportCount": study.reportCount,
//                "studyImagePath": study.studyImagePath,
//                "studyCount" : study.studyCount,
//                "studyCoordinates": study.studyCoordinates])
//
//        fetchFeeds()
//    }
//
//
//    func removeFeed(_ study: StudyRecruitModel) {
//        dbRef.document(study.id).delete()
//        fetchFeeds()
//    }
    
    
    //TODO: document 문서번호가 지정이 안되어있음.
    ///이미지 경로 반환함수
    func returnImagePath(item: PhotosPickerItem) async -> String {
        do {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return ""
            }
            do {
                let (_, _, url) = try await StorageManger.shared.saveImage(data: data, id: dbRef.document().documentID)
                return url.absoluteString
            } catch {
                print("\(error.localizedDescription)")
            }
        } catch(let error) {
            print("\(error.localizedDescription)")
        }
        return  ""
    }
    
    
    
//    func returnImagePath(item: PhotosPickerItem, completion: @escaping (String?) -> Void) async {
//        Task {
//            guard let data = try await item.loadTransferable(type: Data.self) else {
//                completion(nil)
//                return
//            }
//            let (_, _, url) = try await StorageManger.shared.saveImage(data: data, id: dbRef.document().documentID)
//            completion(url.absoluteString)
//        }
//    }
    
    
    func saveStudyImage(item: PhotosPickerItem) {
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name, url) = try await StorageManger.shared.saveImage(data: data, id: dbRef.document().documentID)
            print("SUCCESS!!!!") //엄청난 희열이 느껴진다..!
            print("path : \(path)")
            print("name : \(name)")
            print("url : \(url)")
        }
    }
}
