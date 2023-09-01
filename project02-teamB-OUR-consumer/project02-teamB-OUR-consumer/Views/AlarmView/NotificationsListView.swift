//
//  NotificationsListView.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI
import AVFoundation

// 알림 목록 뷰
struct NotificationsListView: View {
    
    @EnvironmentObject var alarmViewModel: AlarmViewModel
    @StateObject var study: StudyViewModel = StudyViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    
    var access: NotificationType.Access
    
    var body: some View {
        List {
            switch access {
            case .personal:
                makeListAlarmView(items: alarmViewModel.personalNotiItem)
            case .public:
                makeListAlarmView(items: alarmViewModel.publicNotiItem)
            case .none:
                EmptyView()
            }
        }
        .onAppear{
            alarmViewModel.fetchNotificationItem()
        }
        .refreshable {
            // 새로고침 로직
            alarmViewModel.fetchNotificationItem()
        }
        .listStyle(PlainListStyle()) // 하얀색 배경
    }
    
    
    func makeListAlarmView(items: NotiItem) -> some View{
        ForEach(items.keys.sorted(by: >), id: \.self) { key in
            // key 비어있지 않으면 Section 추가
            if let notifications = items[key], !notifications.isEmpty {
                Section(header:
                            Text("\(key)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color.black),
                        content:  {
                    ForEach(items[key]!, id: \.id) { notification in
                        
                        makeNotificationRow(notification: notification)
                        
                    }.onDelete(perform: { offset in
                        // key
                        alarmViewModel.delete(notification: offset, access: access, key: key)
                    })
                })
            }
        }
    }
    
    func makeNotificationRow(notification: NotificationItem) -> some View {
        if let following = userViewModel.user?.following,
           following.contains(notification.userId){
            return NotificationRow(notification: notification,isFollowing: true,access: access)
                .environmentObject(study)
        }
        return NotificationRow(notification: notification,isFollowing: false,access: access)
            .environmentObject(study)
    }
}

// 알림 행
struct NotificationRow: View {
    let notification: NotificationItem
    @State var isFollowing: Bool = false // 팔로우 상태 추적
    @EnvironmentObject var studyViewModel: StudyViewModel
    @EnvironmentObject var alarmViewModel: AlarmViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State var isLoading = true
    
    var access: NotificationType.Access
    
    var body: some View {
        HStack {
            ZStack {
                if notification.type == .like || notification.type == .comment {
                    NavigationLink(destination:
                                    FeedView()
                    ) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                    }
                }
                
                if notification.type == .follow{
                    NavigationLink(destination: MyMain())
                    {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                    }
                }
                
                
                if notification.type == .studyReply || notification.type == .studyAutoJoin {
                    NavigationLink(destination: StudyDetailView(viewModel: studyViewModel, study: studyViewModel.studyArray.first ?? StudyDTO.defaultStudy, isSavedBookmark: true))
                    {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                    }
                }
                
                HStack{
                    // 사용자 이미지
                    Circle()
                        .fill(AColor.defalut.color)
                        .frame(width: 40, height: 40)
                    
                    // 텍스트
                    VStack(alignment: .leading) {
                        HStack{
                            styledText(content: notification.content)
                                .font(.system(size: 12, weight: .medium))
                            
                            if access == .public{
                                Spacer()
                            }
                        }
                        
                        Text(DateCalculate().caluculateTime(notification.createdDate.toString()))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(Color.gray)
                    }
                    
                    // 팔로우/팔로잉 버튼 (해당되는 경우)
                    if notification.type == .follow {
                        Spacer()
                        
                        // 팔로우 버튼만 오른쪽으로 밀기
                        //                            Spacer()
                        Text(isFollowing ? "팔로잉" : "팔로우")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(isFollowing ? AColor.main.color : Color.white)
                            .frame(width: 80, height: 27.85)
                            .background(isFollowing ? Color.white : AColor.main.color)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(AColor.main.color, lineWidth: 2))
                            .onTapGesture {
                                isFollowing.toggle()
                                sound(is: isFollowing)
                                following(is: isFollowing){ id, type in
                                    alarmViewModel.sendNotification(userId: id, type: type)
                                }
                                // 임시 푸시알림
                                UNNotificationService.shared.requestSendNoti(seconds: 0.1,
                                                                             type: notification.type,
                                                                             body: notification.content)
                            }
                    }
                    
                    // 게시물 이미지 (좋아요, 댓글 알림에만 표시)
                    if notification.type == .like || notification.type == .comment,
                       let imageUrl = notification.imageURL {
                        Spacer()
                        RemoteImage(url: imageUrl)
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
        .redacted(reason: isLoading ? .placeholder : [])
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoading = false
            }
            if let userID = UserDefaults.standard.string(forKey: Keys.userId.rawValue) {
                userViewModel.fetchUser(userId: userID)
            }
        }
    }
    
    
    
    func following(is following: Bool, completion: @escaping (ID,NotificationType) -> () ) {
        
        following ?
        userViewModel.followUser(targetUserId: notification.userId, completion: completion)
        :
        userViewModel.unfollowUser(targetUserId: notification.userId)
    }
    
    func sound(is following: Bool) {
        // (숫자)바꾸면 기본 제공 효과음
        if following {
            AudioServicesPlaySystemSound(1004)
        } else {
            AudioServicesPlaySystemSound(1003)
        }
    }
    
    func styledText(content: String) -> Text {
        var output = Text("")
        let components = content.tokenize("@#. ")
        for component in components {
            if component.rangeOfCharacter(from: CharacterSet(charactersIn: "@#")) != nil {
                print("styledText: \(component)")
                output = output + Text(component).foregroundColor(.accentColor)
            } else {
                print("styledText2: \(component)")
                output = output + Text(component)
            }
        }
        return output
    }
}

struct NotificationsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NotificationsListView(access: .personal)
                .environmentObject(AlarmViewModel(dependency: .init(alarmFireSerivce: AlarmFireService())))
        }
    }
}
