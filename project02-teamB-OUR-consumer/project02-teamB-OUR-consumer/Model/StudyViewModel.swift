//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

struct Study2: Identifiable {
    // 디비에 올라갈 내용
    var id: UUID = UUID()
    var imageURL: String
    var creatorId: String
    var title: String
    var description: String
    var studyDate: String
    var deadline: String
    var location: String
    var isOnline: Bool
    var currentMemberIds: [String]
    var totalMemberCount: Int
    
    // 뷰에서 추가적으로 더 쓰일 내용
    var isSaved: Bool = false
}

class StudyViewModel: ObservableObject {
    let dbRef = Firestore.firestore()
    @Published var studyArray: [Study2] = []
    
    // 전체 스터디 가져오기 => viewwillAppear 할 때 마다 호출하기
    func fetchStudy() {
        dbRef.collection("studyGroup").getDocuments { (snapshot, error) in
            self.studyArray.removeAll()
            
            if let snapshot {
                var temp: [Study2] = []
                for document in snapshot.documents {
                    let id: UUID = document.documentID.stringToUUID() ?? UUID()
                    let docData: [String: Any] = document.data()
                    let imageURL: String = docData["imageURL"] as? String ?? ""
                    let creatorId: String = docData["creatorId"] as? String ?? ""
                    let title: String = docData["title"] as? String ?? ""
                    let description: String = docData["description"] as? String ?? ""
                    let studyDate: String = docData["studyDate"] as? String ?? Date().toString()
                    let deadline: String = docData["deadline"] as? String ?? Date().toString()
                    let location: String = docData["location"] as? String ?? ""
                    let isOnline: Bool = docData["isOnline"] as? Bool ?? false
                    let currentMemberIds: [String] = docData["currentMemberIds"] as? [String] ?? []
                    let totalMemberCount: Int = docData["totalMemberCount"] as? Int ?? 0
                    
                    if self.filterWithDeadline(deadline: deadline) {
                        continue
                    }
                    
                    // 저장한 스터디인지 체크하기
                    self.isSavedStudy(id.uuidString) { isSaved in
                        if isSaved {
                            let study = Study2(id: id, imageURL: imageURL, creatorId: creatorId, title: title, description: description, studyDate: studyDate, deadline: deadline, location: location, isOnline: isOnline, currentMemberIds: currentMemberIds, totalMemberCount: totalMemberCount, isSaved: true)
                            temp.append(study)
                        } else {
                            let study = Study2(id: id, imageURL: imageURL, creatorId: creatorId, title: title, description: description, studyDate: studyDate, deadline: deadline, location: location, isOnline: isOnline, currentMemberIds: currentMemberIds, totalMemberCount: totalMemberCount, isSaved: false)
                            temp.append(study)
                        }
                    }
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
    func addSavedStudy(_ study: Study2) {
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
    func isMyStudy(_ study: Study2) -> Bool {
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
    func addJoinStudy(_ study: Study2) {
        
    }
    
//    // 내가 이미 참여한 스터디인지 check하기
//    func isAlreadyJoinStudy(_ study: Study2) -> Bool {
//        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
//            return false
//        }
//
//        if study.currentMemberIds.contains
//    }
}
