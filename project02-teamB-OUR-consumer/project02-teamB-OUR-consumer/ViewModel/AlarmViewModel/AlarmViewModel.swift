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
    
    
    @Published var personalNotiItem: NotiItem = [:]
    @Published var publicNotiItem: NotiItem = [:]
    
    
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
    
    
    
    func fetchNotificationItem(limit: Int = 10){
        service.read{ [weak self] ids, notifiationDTO in
            guard let self else { return }
            let items = notifiationDTO.map{ $0.toDomain(user: self.getUser(user: $0.userId) )  }
            personalNotiItem = mapToDictionary(items: items).0
            publicNotiItem = mapToDictionary(items: items).1
        }
    }
    
    
    func delete(notification id: ID){
    }
    
    
    func update(isRead item: NotificationItem){
    }
    
    
    func remove(items: NotificationItem){
        //FireBase remove Logic
    }
    
    
    private func getUser(user id: ID) -> User{
        // find user
        return ["박형환","박찬호","장수지"].randomElement().map{ User(id: id, name: $0) }!
        //firebase find user
    }
    
    
    /// Mapping To View Model
    /// - Parameter items: notification Item
    /// - Returns: public , personal
    private func mapToDictionary(items: [NotificationItem]) -> (NotiItem,NotiItem){
        return items.reduce(into: (NotiItem(),NotiItem()), { original, item in
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
                            createdDate: "2023-06-21 13:50:39".toDate())]
    }
}
