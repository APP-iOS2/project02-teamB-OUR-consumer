//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

struct Study: Identifiable, Codable {
    // 디비에 올라갈 내용
    var id: String = UUID().uuidString
    var imageString: String?
    var creatorId: String
    var title: String
    var description: String
    var studyDate: String
    var deadline: String
    var locationName: String?
    // geopoint => codable 안되어서 double,double로 줘야함
    var locationCoordinate: [Double]?
    var isOnline: Bool
    var linkString: String?
    var currentMemberIds: [String]
    var totalMemberCount: Int
    // timestamp => coable 안되어서 string으로 줘야 함
    var createdAt: String
    
    var comments: [StudyGroupComment] = []
}

struct StudyGroupComment: Identifiable, Codable {
    var id: String = UUID().uuidString
//    var profileImage: String?
////    var studyPostID: String // 다시 확인하기!
    var userId: String
    var content: String
    var createdAt: String
   // var reportCount: Int
  //  var reportContent: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case content = "content"
        case createdAt = "createdAt"
    }
}


class StudyViewModel: ObservableObject {
    
    let dbRef = Firestore.firestore()
    
    @Published var studyArray: [Study] = []
    
    // 전체 스터디 가져오기 => viewwillAppear 할 때 마다 호출하기
    func fetchStudy() {
        dbRef.collection("studyGroup").getDocuments { (snapshot, error) in
            self.studyArray.removeAll()
            
            if let snapshot {
                var temp: [Study] = []
                for document in snapshot.documents {
                    let id: String = document.documentID as? String ?? ""
                    let docData: [String: Any] = document.data()
                    //let imageString: String = docData["imageString"] as? String ?? ""
                    let creatorId: String = docData["creatorId"] as? String ?? ""
                    let title: String = docData["title"] as? String ?? ""
                    let description: String = docData["description"] as? String ?? ""
                    let studyDate: String = docData["studyDate"] as? String ?? Date().toString()
                    //시간 추가
                    let deadline: String = docData["deadline"] as? String ?? Date().toString()
                    let locationName: String = docData["locationName"] as? String ?? ""
                    let locationCoordinate: String = docData["locationCoordinate"] as? String ?? ""
                    let isOnline: Bool = docData["isOnline"] as? Bool ?? false
                    let urlString: String = docData["urlString"] as? String ?? ""
                    let currentMemberIds: [String] = docData["currentMemberIds"] as? [String] ?? []
                    let totalMemberCount: Int = docData["totalMemberCount"] as? Int ?? 0
                    let createdAt: String = docData["createdAt"] as? String ?? ""
                    //let isSaved: Bool = docData["isSaved"] as? Bool ?? false
                    //let comments: StudyGroupComment = docData["studyGroupComment"] as? StudyGroupComment ?? StudyGroupComment(profileImage: "이미지 없음", studyPostID: "studyPost ID fetch 실패", userID: "user ID fetch 실패", content: "없음", createdDate: Date())
                    
                    let study = Study(id: id, creatorId: creatorId, title: title, description: description, studyDate: studyDate, deadline: deadline, isOnline: false, currentMemberIds: currentMemberIds, totalMemberCount: totalMemberCount, createdAt: createdAt)
                    temp.append(study)
                    
                    if self.filterWithDeadline(deadline: deadline) {
                        continue
                    }
                    
                    // 저장한 파일인지 가져오기
//                    self.isSavedStudy(id.uuidString) { isSaved in
//                        if isSaved {
//                            let study = Study(id: id, imageString: imageString, creatorId: creatorId, title: title, description: description, studyDate: studyDate, deadline: deadline, locationName: locationName, locationCoordinate: locationCoordinate, isOnline: isOnline, urlString: urlString, currentMemberIds: currentMemberIds, totalMemberCount: totalMemberCount, createdAt: createdAt, isSaved: true, comment: [comments])
//                            temp.append(study)
//                        } else {
//                            let study = Study(id: id, imageString: imageString, creatorId: creatorId, title: title, description: description, studyDate: studyDate, deadline: deadline, locationName: locationName, locationCoordinate: locationCoordinate, isOnline: isOnline, urlString: urlString, currentMemberIds: currentMemberIds, totalMemberCount: totalMemberCount, createdAt: createdAt, isSaved: false, comment: [comments])
//                            temp.append(study)
//                        }
//                    }
                }
                self.studyArray = temp
            }
        }
    }
    
    func fetchComments(index: Int, documentId: String) {
        dbRef.collection("studyGroup").document(documentId).collection("comments").getDocuments { [self] (snapshot, error) in
            if let snapshot {
                for document in snapshot.documents {
                    do {
                        var item = try document.data(as: StudyGroupComment.self)
                        item.id = document.documentID
                        self.studyArray[index].comments.append(item)
                    } catch let error {
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
    
    // 데드라인에서 지났는지 체크, 지났으면 true 반환
    func filterWithDeadline(deadline: String) -> Bool {
        let date = deadline.toDateWithSlash()
        let today = Date()
        if date < today {
            return true
        }
        return false
    }
    
    // 스터디 저장 버튼 눌렀을 때 데이터베이스에 저장하기
    func addSavedStudy(_ study: Study) {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        
        var savedStudyArray: [String] = [study.id]
        dbRef.collection("users").document(userId)
            .getDocument() { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    return
                } else {
                    let docData = snapshot?.data()
                    let temp: [String] = docData?["savedStudyId"] as? [String] ?? []
                    savedStudyArray += temp
                }
            }
        
        dbRef.collection("users").document(userId)
            .setData([
                "savedStudyId": savedStudyArray
            ])
    }
    
    // 내가 저장한 글인지 check하기
    func isSavedStudy(_ studyId: String, completion: @escaping (Bool) -> Void) {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            completion(false)
            return
        }
        
        dbRef.collection("users").document(userId)
            .getDocument() { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(false)
                } else {
                    let docData = snapshot?.data()
                    let temp: [String] = docData?["savedStudyId"] as? [String] ?? []
                    
                    // 이미 저장한 스터디면, return true
                    if temp.contains(studyId) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
    }
    
    // 내가 쓴 글인지 check하기
    func isMyStudy(_ study: Study) -> Bool {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return false
        }
        // 작성자 id와 내 id가 같다면
        if study.creatorId == userId {
            return true
        } else {
            return false
        }
    }
    
    // 참여하기 누르기
    func addJoinStudy(_ study: Study) {
        
    }
    
    //    // 내가 이미 참여한 스터디인지 check하기
    //    func isAlreadyJoinStudy(_ study: Study2) -> Bool {
    //        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
    //            return false
    //        }
    //
    //        if study.currentMemberIds.contains
    //    }
    
    
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

