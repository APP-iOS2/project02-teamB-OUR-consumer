//
//  AlramViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI
import Firebase


typealias ASection = String
typealias NotiItem = [ASection : [NotificationItem]]

class AlarmViewModel: ObservableObject{
    
    private var service: AlarmFireService
    
//    @Published var hasUnreadData: Bool = false // 뱃지 표시 여부
    @Published var personalNotiItem: NotiItem = [:]
    @Published var publicNotiItem: NotiItem = [:]
    
    var personalIds: [String] = []
    var publicIds: [String] = []
    
    init(dependency: AlarmFireService = AlarmFireService()){
        self.service = dependency
    }
 
    #if DEBUG
    // sample model 생성
    func createNoti(){
        let personal = DummyModel.getPersonal()
        let publicmodel = DummyModel.getPublic()
        personal.forEach { model in
            service.create(send: model, completion: { value in
                print("success : \(value)")
                print("sampleModel : \(model)")
            })
        }
        publicmodel.forEach { model in
            service.create(send: model, completion: { value in
                print("success2: \(value)")
                print("sampleModel2: \(model)")
            })
        }
    }
    #endif
    
    
    
    func fetchNotificationItem(limit: Int = 10) {
        service.read { [weak self] ids, notifiationDTO in
            guard let self = self else { return }
            
            let items = notifiationDTO.compactMap { $0.toDomain(user: self.getUser(user: $0.userId) ?? User(name: "", email: "", profileImage: "", profileMessage: "")) }
            
            personalNotiItem = self.mapToDictionary(items: items,ids: ids).0
            publicNotiItem = self.mapToDictionary(items: items,ids: ids).1
//            // 읽지 않은 알림이 있는지 확인하여 뱃지 표시 여부 결정
//            self.hasUnreadData = notifiationDTO.contains { !$0.isRead }
        }
    }
    
//    func removeRows(at offsets: IndexSet) {
//        personalNotiItem.remove(atOffsets: offsets)
//    }
        
    func delete(notification set: IndexSet?, access: NotificationType.Access){
        if let set{
            var willDeleteIds: [ID] = []
            
            switch access {
            case .public:
                for index in set{
                    willDeleteIds.append(publicIds[index])
                }
            case .personal:
                for index in set{
                    willDeleteIds.append(personalIds[index])
                }
            case .none:
                return
            }
            
            service.delete(ids: willDeleteIds, completion: { string in
                print("Delete Success \(string)")
            })
        }else{
            switch access {
            case .public:
                service.delete(ids: publicIds, completion: { string in
                    print("Delete Success \(string)")
                })
            case .personal:
                service.delete(ids: personalIds, completion: { string in
                    print("Delete Success \(string)")
                })
            case .none:
                return
            }
        }
    }
    
    func delete(ids: [ID]){
        service.delete(ids: ids, completion: { string in
            print("Delete Success \(string)")
        })
    }
    
    
    func update(isRead item: NotificationItem){
        
    }
    
    
    func remove(items: NotificationItem){
        //FireBase remove Logic
    }
    
    

    private func getUser(user id: ID) -> User?{
        guard
            let sampleUserName = ["박형환","박찬호","장수지"].randomElement()
        else {return nil}
        
        return User(name: sampleUserName,
                    email: "",
                    profileImage: "",
                    profileMessage: "")
    }
    
    
    /// Mapping To View Model
    /// - Parameter items: notification Item
    /// - Returns: public , personal
    private func mapToDictionary(items: [NotificationItem],ids: [ID]) -> (NotiItem,NotiItem){
        return zip(items, ids).reduce(into: (NotiItem(),NotiItem()), { original, models in
            
            let (item, id) = models
            
            if item.type.getAccessLevel() == .personal{
                let dotDate = item.createdDate.dotString()
                if let items = original.0[dotDate]{
                    original.0[dotDate] = items + [item]
                    personalIds.append(id)
                }else{
                    original.0[dotDate] = [item]
                    personalIds = [id]
                }
            }else {
                let dotDate = item.createdDate.dotString()
                if let items = original.1[dotDate]{
                    original.1[dotDate] = items + [item]
                    publicIds.append(id)
                }else{
                    original.1[dotDate] = [item]
                    publicIds = [id]
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
                            createdDate: "2023-06-21 13:50:39".toDate())]
    }
}
