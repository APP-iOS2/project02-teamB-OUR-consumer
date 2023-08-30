//
//  StudyViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 마경미 on 24.08.23.
//

import Foundation
import FirebaseFirestore

struct ReportData: Codable {
    // 신고 사유
    let reason: String
    // 신고한 사람
    let userId: String
}

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
    var comments: [StudyComment] = []
    var reportReasons: [String] = []
    var reportUserIds: [String] = []
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
    @Published var selectedStudy: StudyDTO = StudyDTO.defaultStudy
    @Published var studyDetail: StudyDetail = StudyDetail.defaultStudyDetail
    
    // 전체 스터디 가져오기 => listview 호출
    func fetchStudy() {
//        studyDetail = StudyDetail.defaultStudyDetail
        dbRef.collection(.studyGroup).getDocuments { (snapshot, error) in
            if let snapshot {
                var temp: [StudyDTO] = []
                for document in snapshot.documents {
                    do {
                        var item = try document.data(as: StudyDTO.self)
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
                        self.getUserInfo(userId: item.userId) { user in
                            // 여기가 studygroupcomment -> studycomment로 변환
                            comments.append(item.toStudyComments(user: user!))
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
            print(userId)
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
    func makeStudyDetail(study: StudyDTO, completion: @escaping() -> Void){
        getUserInfo(userId: study.creatorId) { creator in
            self.getUsersInfo(userIds: study.currentMemberIds) { currentMembers in
                self.fetchComments(documentId: study.id ?? "") { comments in
                    let studyDetail = study.toStudyDetail(creator: creator ?? User.defaultUser, currentMembers: currentMembers, comments: comments)
                    print(studyDetail)
                    self.studyDetail = studyDetail
                    completion()
                }
            }
        }
    }
    
    func reloadStudyDetail() {
        dbRef.collection(.studyGroup).document(studyDetail.id).getDocument(as: StudyDTO.self) { result in
            switch result {
            case .success(let response):
                print(response)
                self.makeStudyDetail(study: response) {
                    
                }
            case .failure(let error):
                print("Error reload study Detail \(error)")
            }
        }
    }
//    
//    func isAlreadyReported() -> Bool {
//        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
//            return false
//        }
//        dbRef.collection(.studyGroup).document(self.studyDetail.id).getDocument(as: StudyDTO.self)
//    }
    
    func reportStudy(report: ReportData) {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        self.studyDetail.reportReasons.append(report.reason)
        self.studyDetail.reportUserIds.append(report.userId)
        dbRef.collection(.studyGroup).document(self.studyDetail.id).updateData([
            "reportReason": self.studyDetail.reportReasons,
            "reportUserId": self.studyDetail.reportUserIds
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        reloadStudyDetail()
    }
    
    // 참여하기 누르기
    func addJoinStudy(_ study: StudyDTO) {
        
    }
    
    func sortedStudy(sorted: StudyList) -> [StudyDTO] {
        switch sorted {
        case .allList:
            let sortedArray = studyArray.sorted { $0.createdAt > $1.createdAt }
            return sortedArray
        case .onlineList:
            let sortedArray = studyArray.filter { $0.isOnline }.sorted { $0.createdAt > $1.createdAt }
            return sortedArray
        case .offlineList:
            let sortedArray = studyArray.filter { !$0.isOnline }.sorted { $0.createdAt > $1.createdAt }
            return sortedArray
        }
    }
}

