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
    var imageString: [String]?
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
    var isJoined: Bool
}

extension StudyDetail {
    static var defaultStudyDetail: StudyDetail {
        return StudyDetail(creator: User.defaultUser, title: "", description: "", studyDate: "", deadline: "", isOnline: false, currentMembers: [], totalMemberCount: 0, comments: [], isJoined: false)
    }
}

// 실제로 사용할 comment 구조체
struct StudyComment: Identifiable {
    var id: String = UUID().uuidString
    var user: User
    var content: String
    var createdAt: String
    
    var isMine: Bool {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return false
        }
        return user.id == userId ? true : false
    }
}

extension StudyComment {
    static var defaultComment: StudyComment {
        return StudyComment(user: User.defaultUser, content: "", createdAt: "")
    }
}

class StudyViewModel: ObservableObject {
    let dbRef = Firestore.firestore()
    // fetch하고 나서 결과를 = 결과 , 이게 아니라 append(결과)
    @Published var studyArray: [StudyDTO] = []
    @Published var selectedStudy: StudyDTO = StudyDTO.defaultStudy
    @Published var studyDetail: StudyDetail = StudyDetail.defaultStudyDetail
    @Published var selectedComment: StudyComment = StudyComment.defaultComment
    @Published var alertCase: StudyDetailAlert = .normal
    
    // MARK: 전체 스터디 불러오는 함수
    func fetchStudy() {
        dbRef.collection(.studyGroup).getDocuments { (snapshot, error) in
            if let snapshot {
                var temp: [StudyDTO] = []
                for document in snapshot.documents {
                    do {
                        let item = try document.data(as: StudyDTO.self)
                        temp.append(item)
                    } catch let error {
                        print(error)
                        return
                    }
                }
                self.studyArray = temp
            }
        }
    }
    
    // MARK: StudyCommentDTO -> StudyComment로 바꾸면서 User 정보를 포함시키는 함수
    func fetchComments(documentId: String) async -> [StudyComment] {
        do {
            let snapshot = try await dbRef.collection(.studyGroup).document(documentId).collection("comments").getDocuments()
            
            var comments: [StudyComment] = []
            
            for document in snapshot.documents {
                do {
                    let item = try await document.data(as: StudyCommentDTO.self)
                    if let user = await self.getUserInfo(userId: item.userId ?? "") {
                        let studyComment = item.toStudyComments(user: user)
                        comments.append(studyComment)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    continue
                }
            }
            let sortedArray = comments.sorted { $0.createdAt.toDate() < $1.createdAt.toDate() }
            return sortedArray
        } catch let error {
            print(error.localizedDescription)
            return []
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
    
    // MARK: 한 명의 User 정보 불러오기
    func getUserInfo(userId: String) async -> User? {
        do {
            let documentSnapshot = try await dbRef.collection(.users).document(userId).getDocument()
            
            if let user = try? documentSnapshot.data(as: User.self) {
                return user
            } else {
                print("Error decoding user data")
                return nil
            }
        } catch {
            print("Error fetching user document: \(error)")
            return nil
        }
    }
    
    func getUsersInfo(userIds: [String]) async -> [User] {
        var members: [User] = []
        
        for userId in userIds {
            do {
                let documentSnapshot = try await dbRef.collection(.users).document(userId).getDocument()
                if let user = try? documentSnapshot.data(as: User.self) {
                    members.append(user)
                } else {
                    print("Error decoding user document for userID: \(userId)")
                }
            } catch {
                print("Error fetching user document: \(error)")
            }
        }
        
        return members
    }
    
    // MARK: DB에서 받아온 StudyDTO를 실제 view에서 사용할 StudyDetail로변환하는 함수
    @MainActor
    func makeStudyDetail(study: StudyDTO) async {
        let creator = await getUserInfo(userId: study.creatorId)
        let currentMembers = await getUsersInfo(userIds: study.currentMemberIds)
        let comments = await fetchComments(documentId: study.id ?? "")
        let isJoned = await getMyInfo(studyId: study.id ?? "")
        
        let studyDetail = study.toStudyDetail(creator: creator ?? User.defaultUser, currentMembers: currentMembers, comments: comments, isJoined: isJoned)
        self.studyDetail = studyDetail
    }
    
    // MARK: 스터디를 reload 해야할 때 쓰이는 함수
    func reloadStudyDetail() async {
        do {
            let documentSnapshot = try await dbRef.collection(.studyGroup).document(studyDetail.id).getDocument()
            if let studyDTO = try? documentSnapshot.data(as: StudyDTO.self) {
                await makeStudyDetail(study: studyDTO)
            } else {
                print("Error decoding study document")
            }
        } catch {
            print("Error reloading study Detail: \(error)")
        }
    }
    
    func reportStudy(report: ReportData) async {
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
        await reloadStudyDetail()
    }
    
    // 참여하기 누르기
    func joinStudy() async {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        do {
            try await dbRef.collection(.users).document(userId).updateData([
                "joinedStudy": FieldValue.arrayUnion([studyDetail.id])
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
        do {
            try await dbRef.collection(.studyGroup).document(studyDetail.id).updateData([
                "currentMemberIds": FieldValue.arrayUnion([userId])
            ])
        } catch {
            print("Error updating currentMemberids: \(error)")
        }
        await reloadStudyDetail()
    }
    
    func addComments(content: String) async {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        let request = StudyCommentDTO(userId: userId, content: content, createdAt: Date().toString())
        do {
            try await dbRef.collection(.studyGroup).document(studyDetail.id).collection(.studyComments).addDocument(from: request)
        } catch {
            print("Error adding doucment")
        }
        
        await reloadStudyDetail()
    }
    
    func deleteComment() async {
        do {
            try await dbRef.collection(.studyGroup)
                .document(studyDetail.id)
                .collection(.studyComments)
                .document(selectedComment.id)
                .delete()
            print("Document successfully removed")
        } catch {
            print("Error removing document: \(error)")
        }
        
        await reloadStudyDetail()
    }
    
    // getMyInfo로 바꿀까 고민중
    func getMyInfo(studyId: String) async -> Bool {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return false
        }
        do {
            let documentSnapshot = try await dbRef.collection(.users).document(userId).getDocument()
            if let myInfo = try? documentSnapshot.data(as: User.self),
               let joinedStudy = myInfo.joinedStudy {
                if joinedStudy.contains(studyId) {
                    return true
                }
            } else {
                print("Error decoding myInfo")
            }
        } catch {
            print("Error GetMyInfo: \(error)")
        }
        return false
    }
    
    
    func updateBookmark(studyID: String) {
        
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        dbRef.collection(.users).document(userId).updateData(["savedStudyIDs": FieldValue.arrayUnion([studyID])])
        print("update")
    }
    
    func removeBookmark(studyID: String) {
        guard let userId = UserDefaults.standard.string(forKey: Keys.userId.rawValue) else {
            return
        }
        dbRef.collection(.users).document(userId).updateData(["savedStudyIDs": FieldValue.arrayRemove([studyID])])
        print("remove")
    }
    
    //스터디 피드 삭제
    func deleteStudy(studyID: String) {
        dbRef.collection(.studyGroup).document(studyID).delete { error in
            if let error = error {
                print("Study delete failed: \(error)")
            }
        }
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

