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
    let userID: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue ) ?? ""
    
    let service = RecruitService()
//    private let userCollection = Firestore.firestore().collection("StudyPosts")
//
    
    let dbRef = Firestore.firestore().collection(Recruit.collection.studypost.rawValue)
    
    
    
    func fetchFeeds() {

        service.fetchAll(collection: .studypost) { results in
            self.studyStores = results
        }
    }
    
    func addFeed(_ study: StudyRecruitModel) {
        var temp = study
        temp.creator = userID
        
        //만약 StudyRecruitModel에서 currentMemberIds의 타입이 옵셔널일 경우
        //여기서 옵셔널처리를 해줘야한다. -> nil일경우 빈배열을 생성해주는 작업.
        temp.currentMemberIds.insert(userID, at: 0) //스터디참여멤버에 작성자 미리 추가해놓기
 
        service.add(collection: .studypost, data: temp)
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
    
    
//    TODO: document 문서번호가 지정이 안되어있음.
//    /이미지 경로 반환함수
    func returnImagePath(items: [PhotosPickerItem]) async throws -> [String]{

        var urlString:[String] = []

        for item in items {

            guard let data = try? await item.loadTransferable(type: Data.self) else {return urlString}
            print("원래데이터 크기:\(data.count)")

            guard let uiImage = UIImage(data: data) else {return urlString}
            guard let compressImage = uiImage.jpegData(compressionQuality: 0.5) else {return urlString}
            print("변형된 데이터 크기:\(compressImage.count)")

            do {
                let (_, _, url) = try await StorageManger.shared.saveImage(data: compressImage, id: dbRef.document().documentID)

                urlString.append(url.absoluteString)
            } catch {
                print("리턴이미지패스\(error.localizedDescription)")
            }

        }

        return urlString
    }
    
//    func returnImagePath(item: [PhotosPickerItem], completion: @escaping (String?) -> Void) async {
//
//        for index in item {
//            guard let data = try await index.loadTransferable(type: Data.self) else {
//                completion(nil)
//                return
//            }
//            let (_, _, url) = try await StorageManger.shared.saveImage(data: data, id: dbRef.document().documentID)
//            completion(url.absoluteString)
//
//        }
//
//
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


