//
//  AlramViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI
import Firebase
import Combine

typealias ASection = String
typealias NotiItem = [ASection : [NotificationItem]]

class AlarmViewModel: ObservableObject{
    
    private var service: AlarmFireService
    private var userViewModel: UserViewModel
    
    @Published var hasUnreadData: Bool = false // 뱃지 표시 여부
    @Published var personalNotiItem: NotiItem = [:]
    @Published var publicNotiItem: NotiItem = [:]
    
    struct Dependency{
        let alarmFireSerivce: AlarmFireService
        let userViewModel: UserViewModel

    }
    
    init(dependency: Dependency){
        self.service = dependency.alarmFireSerivce
        self.userViewModel = dependency.userViewModel
    }
 
    

    func fetchNotificationItem(limit: Int = 10) {
        service.read(completion: { [weak self] result in
            guard let self else {return }
            switch result{
            case .success(let notificationDTO):
                let items = notificationDTO.compactMap { $0.toDomain(user: self.getUser(user: $0.userId) ?? User(name: "", email: "", profileImage: "", profileMessage: "")) }
                let models = self.mapToDictionary(items: items)
                self.personalNotiItem = models.0
                self.publicNotiItem = models.1
                
                self.hasUnreadData = items.contains { !$0.isRead }
                
                // 이 부분도 로깅으로 확인
                print("hasUnreadData updated to: \(self.hasUnreadData)")
            case .failure(let error):
                print("error: \(error) -- \(#function)")
            }
        })
    }
    

    
        
    func delete(notification set: IndexSet?, access: NotificationType.Access, key: ASection){
        if let set{
            var willDeleteIds: [ID] = []
            
            switch access {
            case .public:
                for index in set{
                    willDeleteIds.append(self.publicNotiItem[key]![index].id)
                }
            case .personal:
                for index in set{
                    willDeleteIds.append(self.personalNotiItem[key]![index].id)
                }
            case .none:
                return
            }
            
            service.delete(ids: willDeleteIds, completion: { string in
                switch access {
                case .public:
                    // 여기에서 메모리 에 있는 데이터 삭제
                    var values = self.publicNotiItem[key]!
                    values.remove(atOffsets: set)
                    self.publicNotiItem[key] = values

                case .personal:
                    // 여기에서 메모리 에 있는 데이터 삭제
                    var values = self.personalNotiItem[key]!
                    values.remove(atOffsets: set)
                    self.personalNotiItem[key] = values
                case .none:
                    return
                }
            })
        }
    }
    
    func delete(ids: [ID]){
        service.delete(ids: ids, completion: { string in
            print("Delete Success \(string)")
        })
    }
    
    
    // notification의 id로 탐색을 할것인가....
    func update(isRead id: ID){
        service.update(id: id, completion: { err in
            if err != nil{
                print("failed update")
            }else{
                print("success update")
            }
        })
    }
    
    func update(isReads ids: [ID]){
        service.update(ids: ids, completion: { err in
            if err != nil{
                print("failed update")
            }else{
                print("success update")
            }
        })
    }
    

    private var cancelable = Set<AnyCancellable>()

    func addNewNotification() {
        // 새로운 알림 데이터를 생성
        let newNotification = NotificationDTO(
            id: UUID().uuidString,
            userId: "새로운 사용자 ID",
            type: "follow",
            content: "@Jane_Smith 님이 게시물을 좋아합니다.",
            isRead: false,
            createdDate: "2023-08-29 13:50:39".toDate() // 현재 날짜와 시간을 설정
        )

        // Firestore 서비스를 통해 데이터를 추가
        service.create(send: newNotification) { result in
            if result == "success" {  // 예시: 성공 시 "success" 문자열 반환
                print("New notification added successfully.")
            } else {
                print("Failed to add new notification.")
            }
        }
    }


    private func getUser(user id: ID) -> User?{
            
        guard
            let sampleUserName = ["박형환","박찬호","장수지"].randomElement()
        else {return nil}
        
        return User(id: nil, name: sampleUserName, email: "", profileImage: nil, profileMessage: nil, follower: nil, following: nil)
    }
    
    
    /// Mapping To View Model
    /// - Parameter items: notification Item
    /// - Returns: public , personal
    private func mapToDictionary(items: [NotificationItem]) -> (NotiItem,NotiItem){
        return items.reduce(into: (NotiItem(),NotiItem()), { original, models in
            let item = models
            if item.type.getAccessLevel() == .personal{
                let dotDate = item.createdDate.dotString()
                if let items = original.0[dotDate]{
                    original.0[dotDate] = items + [item]
                }else{
                    original.0[dotDate] = [item]
                }
            }else {
                let dotDate = item.createdDate.dotString()
                if let items = original.1[dotDate]{
                    original.1[dotDate] = items + [item]
                }else{
                    original.1[dotDate] = [item]
                }
            }
        })
    }
}





struct DummyModel{
    
    static func getPersonalRandom() -> [NotificationDTO]{
        return [
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "follow",
                            content: "@John_Doe 님이 팔로우했습니다 다다다 다다다다 다다.",
                            isRead: false,
                            createdDate: "2023-08-21 13:50:39".toDate()),
            
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "follow",
                            content: "@Jane_Smith 님이 게시물을 좋아합니다.",
                            isRead: false,
                            createdDate: "2022-08-23 13:50:39".toDate()),
            
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "like",
                            content: "@Tom_Johnson 님이 댓글을 남겼습니다.",
                            isRead: false,
                            createdDate: "2023-08-21 13:50:39".toDate())
        ]
    }
    
    
    static func getPersonal() -> [NotificationDTO]{
        return [
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "follow",
                            content: "@John_Doe 님이 팔로우했습니다 다다다 다다다다 다다.",
                            isRead: false,
                            createdDate: "2023-08-21 13:50:39".toDate()),
            
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "follow",
                            content: "@Jane_Smith 님이 게시물을 좋아합니다.",
                            isRead: false,
                            createdDate: "2022-08-23 13:50:39".toDate()),
            
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "like",
                            content: "@Tom_Johnson 님이 댓글을 남겼습니다.",
                            isRead: false,
                            createdDate: "2023-08-21 13:50:39".toDate()),
            
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "comment",
                            content: "@Emily_Davis 님이 팔로우했습니다.",
                            isRead: false,
                            createdDate: "2023-06-21 13:50:39".toDate())
        ]
    }
    
    static func getPublic() -> [NotificationDTO]{
        return [
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "studyAutoJoin",
                            content: "@ddu님이 @Study_X에 가입했습니다.",
                            isRead: false,
                            createdDate: "2023-06-21 13:50:39".toDate()),
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "studyReply",
                            content: "@jjang님이 @Study_X에 댓글을 남겼습니다.",
                            isRead: false,
                            createdDate: "2023-06-21 13:50:39".toDate()),
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "studyReply",
                            content: "@jjang님이 @Study_X에 댓글을 남겼습니다.",
                            isRead: false,
                            createdDate: "2022-06-21 13:50:39".toDate())
        ]
    }
}
