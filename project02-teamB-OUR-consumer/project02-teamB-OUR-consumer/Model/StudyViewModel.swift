//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

// DB에 studygroup에 들어갈 study 전체 내용 (올라가고, 받고)
struct Study: Identifiable, Codable {
    // study Id => 추후 documentId로 바꿀 수도 있음
    var id: String = UUID().uuidString
    // study 배경 Image
    var imageString: String?
    // study를 만든 사람의 id
    var creatorId: String
    // study 제목
    var title: String
    // study 설명
    var description: String
    // study 하는 날짜 (1회성)
    var studyDate: String
    // study원 모집 마감하는 날
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
    
//    enum CodingKeys: String, CodingKey {
//        case imageString = "imageString"
//        case creatorId = "creatorId"
//        case title = "title"
//        case description = "description"
//        case studyDate = "studyDate"
//        case deadline = "deadline"
//        case locationName = "locationName"
//        case locationCoordinate = "locationCoordinate"
//        case isOnline = "isOnline"
//        case linkString = "linkString"
//        case currentMemberIds = "currentMemberIds"
//        case totalMemberCount = "totalMemberCount"
//        case createdAt = "createdAt"
//    }
}

struct StudyDetail {
    var id: String = UUID().uuidString
    var imageString: String?
    var creator: User
    var title: String
    var description: String
    var studyDate: String
    var deadline: String
    var locationName: String?
    var locationCoordinate: [Double]?
    var isOnline: Bool
    var linkString: String?
    var currentMembers: [User]
    var totalMemberCount: Int
    var comments: [StudyComment]
}

extension StudyDetail {
    static var defaultStudyDetail: StudyDetail {
        return StudyDetail(creator: User.defaultUser, title: "", description: "", studyDate: "", deadline: "", isOnline: false, currentMembers: [], totalMemberCount: 0, comments: [])
    }
}

extension Study {
    static var defaultStudy: Study {
        return Study(creatorId: "BMTtH2JFcPNPiofzyzMI5TcJn1S2", title: "test", description: "testetstseteststsets", studyDate: "2023년 9월 30일", deadline: "2023년 8월 30일", isOnline: false, currentMemberIds: [], totalMemberCount: 4, createdAt: "2023년 8월 23일 오전 12시 0분 0초 UTC+9")
    }
}

struct StudyGroupComment: Identifiable, Codable {
    var id: String = UUID().uuidString
    var userId: String
    var content: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case content = "content"
        case createdAt = "createdAt"
    }
}

struct StudyComment: Identifiable {
    var id: String = UUID().uuidString
    var user: User
    var content: String
    var createdAt: String
}

class StudyViewModel: ObservableObject {
    
    let dbRef = Firestore.firestore()
    
    @Published var studyArray: [Study] = []
    
    // 전체 스터디 가져오기 => viewwillAppear 할 때 마다 호출하기
    func fetchStudy() {
        dbRef.collection("studyGroup").getDocuments { [self] (snapshot, error) in
            if let snapshot {
                var temp: [Study] = []
                for document in snapshot.documents {
                    let id = document.documentID
                    do {
                        var item = try document.data(as: Study.self)
                        item.id = document.documentID
//                        if filterWithDeadline(deadline: item.deadline) {
//                            continue
//                        }
                        temp.append(item)
                    } catch let error {
                        print(error.localizedDescription)
                        return
                    }
                }
                self.studyArray = temp
            }
        }
    }
    
    func fetchComments(documentId: String, completion: @escaping ([StudyComment]) -> Void) {
        dbRef.collection("studyGroup").document(documentId).collection("comments").getDocuments { (snapshot, error) in
            if let snapshot {
                var comments: [StudyComment] = []
                for document in snapshot.documents {
                    do {
                        var item = try document.data(as: StudyGroupComment.self)
                        item.id = document.documentID
                        self.getUserInfo(userId: item.userId) { user in
                            comments.append(StudyComment(id: document.documentID, user: user ?? User.defaultUser, content: item.content, createdAt: item.createdAt))
                            if comments.count == snapshot.documents.count {
                                completion(comments)
                            }
                        }
                    } catch let error {
                        print(error.localizedDescription)
                        return
                    }
                }
            }
        }
    }
    
    // 데드라인에서 지났는지 체크, 지났으면 true 반환 => 현재는 string to date 변환 필요함
    func filterWithDeadline(deadline: String) -> Bool {
        let date = deadline.toDateWithSlash()
        let today = Date()
        if date < today {
            return true
        }
        return false
    }
    
    func getUserInfo(userId: String, completion: @escaping (User?) -> Void) {
        dbRef.collection(Collections.users.rawValue).document(userId).getDocument(as: User.self) { result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print("Error decoding users: \(error)")
                completion(nil)
            }
        }
    }
    
    func getUsersInfo(userIds: [String], completion: @escaping ([User]) -> Void) {
        var members: [User] = []
        for userId in userIds {
            dbRef.collection(Collections.users.rawValue).document(userId).getDocument(as: User.self) { result in
                switch result {
                case .success(let response):
                    members.append(response)
                case .failure(let error):
                    print("Error decoding users: \(error)")
                }
            }
        }
        completion(members)
    }
    
    func makeStudyDetail(study: Study, completion: @escaping(StudyDetail) -> Void){
        var creator: User = User.defaultUser
        getUserInfo(userId: study.creatorId) { result in
            if let result = result {
                creator = result
            }
            var currentMembers: [User] = []
            self.getUsersInfo(userIds: study.currentMemberIds) { result in
                currentMembers = result
                currentMembers.append(creator)
                self.fetchComments(documentId: study.id) { comments in
                    completion(StudyDetail(id: study.id, creator: creator, title: study.title, description: study.description, studyDate: study.studyDate, deadline: study.deadline, isOnline: study.isOnline, currentMembers: currentMembers, totalMemberCount: study.totalMemberCount, comments: comments))
                }
            }
        }
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

