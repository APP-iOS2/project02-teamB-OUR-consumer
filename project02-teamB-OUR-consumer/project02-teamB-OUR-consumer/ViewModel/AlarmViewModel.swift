//
//  AlramViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI



typealias ASection = String
typealias NotiItem = [ASection : [NotificationItem]]

class AlarmViewModel: ObservableObject{
    
    var personalSection: Set<ASection> = []
    var publicSection: Set<ASection> = []
    
    @Published var personalNotiItem: NotiItem = [:]
    @Published var publicNotiItem: NotiItem = [:]
    
    init(){
        
    }
    
    func fetchAlarm(access: NotificationType.Access, limit: Int = 10){
        // access 분리
        switch access {
        case .public:
            fetchPublic()
        case .personal:
            fetchPersonal()
        case .none:
            break
        }
    }
    
    private func fetchPersonal(){
        let dto = DummyModel.getPersonal()
        let items = dto.map{ convert(with: $0) }
        var result: NotiItem = [:]
        result = items.reduce(into: NotiItem(), { original, item in
            let dotDate = item.createdDate.dotString()
            if let items = original[dotDate]{
                original[dotDate] = items + [item]
                personalSection.insert(dotDate)
            }else{
                original[dotDate] = [item]
            }
        })
        personalNotiItem = result
    }
    
    
    private func fetchPublic(){
        let dto = DummyModel.getPublic()
        let items = dto.map{ convert(with: $0) }
        var result: NotiItem = [:]
        result = items.reduce(into: NotiItem(), { original, item in
            let dotDate = item.createdDate.dotString()
            if let items = original[dotDate]{
                original[dotDate] = items + [item]
                publicSection.insert(dotDate)
            }else{
                original[dotDate] = [item]
            }
        })
        publicNotiItem = result
    }
    
    func update(isRead item: NotificationItem){
        //임시
//        if let index = notificationItems.enumerated().filter({ index, item in item.id == item.id }).first{
//            notificationItems[index.offset] = item
//        }
        
        //FireBase update Logic
    }
    
    func remove(items: NotificationItem){
        
        //FireBase remove Logic
        
        
    }
    
    private func getUser(user id: ID) -> User{
        
        // find user
        return ["박형환","박찬호","장수지"].randomElement().map{ User(id: id, name: $0) }!
        
        //firebase find user
    }
    
    
//    private func convertType(with type: String) -> NotificationType{
//
//        switch type{
//            case "follow"
//        }
//    }
    
    
    private func convert(with item: NotificationDTO) -> NotificationItem {
        // 흠
        let user = getUser(user: item.userId)
        
        let type = NotificationType(rawValue: item.type) ?? .none
        
        return NotificationItem(id: item.id,
                                user: user ,
                                type: type,
                                content: item.content,
                                isRead: item.isRead,
                                imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPvi3WpN86PNtBjUkO1ftQr6Uz7AlzimJicEX67lk9jw&s",
                                createdDate: item.createdDate)
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
                            type: "follow",
                            content: "@Study_X 에 가입 요청했습니다.",
                            isRead: false,
                            createdDate: "2023-06-21 13:50:39".toDate()),
            NotificationDTO(id: UUID().uuidString,
                            userId: UUID().uuidString,
                            type: "follow",
                            content: "@Study_X 에 가입 요청했습니다.",
                            isRead: false,
                            createdDate: "2023-06-21 13:50:39".toDate())]
    }
}
