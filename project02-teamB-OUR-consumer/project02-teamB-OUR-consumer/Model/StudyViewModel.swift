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
    @Published var studyArray: [StudyDTO] = []
    
    // 전체 스터디 가져오기 => listview 호출
    func fetchStudy() {
        dbRef.collection(.studyGroup).getDocuments { (snapshot, error) in
            if let snapshot {
                var temp: [StudyDTO] = []
                for document in snapshot.documents {
                    let id = document.documentID
                    do {
                        // document의 data들을 study구조체로 decoding한다
                        // item 자체가 study의 객체
                        var item = try document.data(as: StudyDTO.self)
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
        dbRef.collection(.studyGroup).document(documentId).collection("comments").getDocuments { (snapshot, error) in
            if let snapshot {
                var comments: [StudyComment] = []
                for document in snapshot.documents {
                    do {
                        // 디코딩할 때 studygroupcomment로 하지만
                        var item = try document.data(as: StucyCommentDTO.self)
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
        dbRef.collection(.users).document(userId).getDocument(as: User.self) { result in
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
            dbRef.collection(.users).document(userId).getDocument(as: User.self) { result in
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
    func makeStudyDetail(study: StudyDTO, completion: @escaping(StudyDetail) -> Void){
        getUserInfo(userId: study.creatorId) { creator in
            self.getUsersInfo(userIds: study.currentMemberIds) { currentMembers in
                self.fetchComments(documentId: study.id!) { comments in
                    completion(study.toStudyDetail(creator: creator ?? User.defaultUser, currentMembers: currentMembers, comments: comments))
                }
            }
        }
    }

    func isAlreadyReportStudy(studyId: String, completion: @escaping (Bool) -> Void) {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }

        dbRef.collection(.studyGroup).document(studyId).getDocument(as: StudyDTO.self) { result in
            switch result {
            case .success(let response):
                if let userIds = response.reportUserId {
                    if userIds.contains(userId) {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            case .failure(let error):
                print("Error getting documents: \(error)")
                return
            }
        }
    }
    
    func reportStudy(studyId: String, report: ReportDTO, completion: @escaping (String?) -> Void) {
        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }

        let query = dbRef.collection(.studyGroup).whereField("reportUserId", arrayContains: userId).getDocuments() { snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            if !snapshot.documents.isEmpty {
                completion("이미 신고가 완료된 스터디입니다.")
            }
        }
        
        dbRef.collection(.studyGroup).document(studyId).updateData([
            "reportReason": FieldValue.arrayUnion([report.reason]),
            "reportUserId": FieldValue.arrayUnion([report.userId])
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
            completion(nil)
        }
    }
    
    // 내가 쓴 글인지 check하기
    func isMyStudy(_ study: StudyDTO) -> Bool {
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
    func addJoinStudy(_ study: StudyDTO) {
        
    }
    
    //    // 내가 이미 참여한 스터디인지 check하기
    //    func isAlreadyJoinStudy(_ study: Study2) -> Bool {
    //        guard let userId: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
    //            return false
    //        }
    //
    //        if study.currentMemberIds.contains
    //    }
    
    
    func sortedStudy() -> [StudyDTO] {
        let sortedArray = studyArray.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    func sortedOnlineStudy() -> [StudyDTO] {
        let sortedArray = studyArray.filter { $0.isOnline }.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
    
    func sortedOfflineStudy() -> [StudyDTO] {
        let sortedArray = studyArray.filter { !$0.isOnline }.sorted { $0.createdAt > $1.createdAt }
        return sortedArray
    }
}

