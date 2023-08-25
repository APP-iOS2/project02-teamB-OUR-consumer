//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

struct Study: Identifiable {
    // 디비에 올라갈 내용
    var id: UUID = UUID()
    //var imageString: String
    var creatorId: String
    var title: String
    //var description: String
    var studyDate: String
    var deadline: String
    var locationName: String?
    //var locationCoordinate: String?
    var isOnline: Bool
    //var urlString: String?
    var currentMemberIds: [String]
    var totalMemberCount: Int
    var createdAt: Double = Date().timeIntervalSince1970
    // var reportCount: Int
    // var reportContent: String
    
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
    
    // 뷰에서 추가적으로 더 쓰일 내용
    //var isSaved: Bool = false
    //var comment: [StudyGroupComment]
}

struct StudyGroupComment: Identifiable {
    var id: UUID = UUID()
    var profileImage: String?
    var studyPostID: String // 다시 확인하기!
    var userID: String
    var content: String
    var createdDate: Date
    // var reportCount: Int
    //  var reportContent: String
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
                    let id: UUID = document.documentID.stringToUUID() ?? UUID()
                    let docData: [String: Any] = document.data()
                    //let imageString: String = docData["imageString"] as? String ?? ""
                    let creatorId: String = docData["creatorId"] as? String ?? ""
                    let title: String = docData["title"] as? String ?? ""
                    //let description: String = docData["description"] as? String ?? ""
                    let studyDate: String = docData["studyDate"] as? String ?? Date().toString()
                    let deadline: String = docData["deadline"] as? String ?? Date().toString()
                    let locationName: String = docData["locationName"] as? String ?? ""
                    //let locationCoordinate: String = docData["locationCoordinate"] as? String ?? ""
                    let isOnline: Bool = docData["isOnline"] as? Bool ?? false
                    //let urlString: String = docData["urlString"] as? String ?? ""
                    let currentMemberIds: [String] = docData["currentMemberIds"] as? [String] ?? []
                    let totalMemberCount: Int = docData["totalMemberCount"] as? Int ?? 0
                    //let createdAt: Double = docData["createdAt"] as? Double ?? 0
                    //let isSaved: Bool = docData["isSaved"] as? Bool ?? false
                    //let comments: StudyGroupComment = docData["studyGroupComment"] as? StudyGroupComment ?? StudyGroupComment(profileImage: "이미지 없음", studyPostID: "studyPost ID fetch 실패", userID: "user ID fetch 실패", content: "없음", createdDate: Date())
                    
                    let study = Study(id: id, creatorId: creatorId, title: title, studyDate: studyDate, deadline: deadline, isOnline: false, currentMemberIds: currentMemberIds, totalMemberCount: totalMemberCount)
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
        
        var savedStudyArray: [String] = [study.id.uuidString]
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

