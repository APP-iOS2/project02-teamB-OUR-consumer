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
    private var myPageViewModel: MypageViewModel
    
    @Published var personalNotiItem: NotiItem = [:]
    @Published var publicNotiItem: NotiItem = [:]
    
    var personalIds: [String] = []
    var publicIds: [String] = []
    
    
    struct Dependency{
        let alarmFireSerivce: AlarmFireService
        let mypageViewModel: MypageViewModel
    }
    
    init(dependency: Dependency){
        self.service = dependency.alarmFireSerivce
        self.myPageViewModel = dependency.mypageViewModel
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
        service.read(completion: { [weak self] result in
            guard let self else {return }
            switch result{
            case .success(let notificationDTO):
                let items = notificationDTO.compactMap { $0.toDomain(user: self.getUser(user: $0.userId) ?? User(name: "", email: "", profileImage: "", profileMessage: "")) }
                let models = self.mapToDictionary(items: items)
                self.personalNotiItem = models.0
                self.publicNotiItem = models.1
            case .failure(let error):
                print("error: \(error) -- \(#function)")
            }
        })
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
                print("Delete Success \(string)")
            })
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
    
    

    private var cancelable = Set<AnyCancellable>()

    private func getUser(user id: ID) -> User?{
        
        _ = myPageViewModel.$user
            .sink(receiveValue: { user in
                print(user)
            })
            
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
                            createdDate: "2023-06-21 13:50:39".toDate())]
    }
}
