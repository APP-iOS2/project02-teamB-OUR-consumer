//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

// 실제로 사용할 study 구조체
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

// 실제로 사용할 comment 구조체
struct StudyComment: Identifiable {
    var id: String = UUID().uuidString
    var user: User
    var content: String
    var createdAt: String
}

class StudyViewModel: ObservableObject {
    let dbRef = Firestore.firestore()
    // fetch하고 나서 결과를 = 결과 , 이게 아니라 append(결과)
    @Published var studyArray: [Study] = []
    
    // 전체 스터디 가져오기 => listview 호출
    func fetchStudy() {
        dbRef.collection("studyGroup").getDocuments { (snapshot, error) in
            if let snapshot {
                var temp: [Study] = []
                for document in snapshot.documents {
                    let id = document.documentID
                    do {
                        // document의 data들을 study구조체로 decoding한다
                        // item 자체가 study의 객체
                        var item = try document.data(as: Study.self)
                        item.id = document.documentID
                        // 필터링을 하려고했는데 날짜가 string이여서 필터링이 안되어서 주석처리
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
    
    // 댓글 가져오기
    // studygroupcomment가 db에 저장될 내용이고 studycomment가 실제로 저희가 사용할 구조체
    // studygroupcomment로 디코딩을해서 studycomment로 돌려주고 있어요
    func fetchComments(documentId: String, completion: @escaping ([StudyComment]) -> Void) {
        dbRef.collection("studyGroup").document(documentId).collection("comments").getDocuments { (snapshot, error) in
            if let snapshot {
                var comments: [StudyComment] = []
                for document in snapshot.documents {
                    do {
                        // 디코딩할 때 studygroupcomment로 하지만
                        var item = try document.data(as: StudyGroupComment.self)
                        item.id = document.documentID
                        // 누가 댓글 달앗는지 알기위해서 getuserInfo를 해요
                        self.getUserInfo(userId: item.userId) { user in
                            // 여기가 studygroupcomment -> studycomment로 변환
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
    
    // 유저 1명 불러오기
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

    // 유저 여러명 불러오기 => 댓글 단 사람전부 또는 참여한 사람 전부
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
    
    // studydetail은 listview->Detailview로 넘어갈 때 사용될 예정입니당
    // 디비에서 가져온 study를 실제로 뷰에 뿌려줄 studydetail로 변환
    // 실제로 studydetailview 이하에서 사용할 데이터를 만드는 메서드
    func makeStudyDetail(study: Study, completion: @escaping(StudyDetail) -> Void){
        var creator: User = User.defaultUser
        // 만든 사람
        getUserInfo(userId: study.creatorId) { result in
            if let result = result {
                creator = result
            }
            var currentMembers: [User] = []
            // 참여한 사람들
            self.getUsersInfo(userIds: study.currentMemberIds) { result in
                currentMembers = result
                currentMembers.append(creator)
                // 댓글
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

