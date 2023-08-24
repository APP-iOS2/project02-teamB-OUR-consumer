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
    
    @EnvironmentObject var viewModel: AlarmViewModel
    
    var access: NotificationType.Access
    
    var body: some View {
        List {
            switch access {
            case .personal:
                makeListAlarmView(items: viewModel.personalNotiItem)
            case .public:
                makeListAlarmView(items: viewModel.publicNotiItem)
            case .none:
                EmptyView()
            }
        }
        .refreshable {
            // 새로고침 로직
        }
        .listStyle(PlainListStyle()) // 하얀색 배경
        .onAppear{
            viewModel.fetchNotificationItem()
        }
    }
    
    func makeListAlarmView(items: NotiItem) -> some View{
        ForEach(items.keys.sorted(by: >),
                id: \.self)
        { key in
            Section(header:
                        Text("\(key)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.black),
                    content:  {
                ForEach(items[key]!, id: \.id) { notification in
                    NotificationRow(notification: notification)
                }
            })
        }
    }
}

// 알림 행
struct NotificationRow: View {
    let notification: NotificationItem
    @State private var isFollowing: Bool = false // 팔로우 상태 추적
    
    var body: some View {
        HStack {
            ZStack {
                if notification.type == .like || notification.type == .comment {
                    NavigationLink(destination:
                                    TestView()
                    ) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                    }
                }
                
                if notification.type == .studyReply || notification.type == .studyAutoJoin {
                    NavigationLink(destination:
                                    TestView()
                    ) {
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
                            
                            Spacer()
                        }
                        
                        Text(DateCalculate().caluculateTime(notification.createdDate.toString()))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color.gray)
                        
                    }
                    
                    // 팔로우/팔로잉 버튼 (해당되는 경우)
                    if notification.type == .follow {
                        Spacer()
                        
                        // 팔로우 버튼만 오른쪽으로 밀기
                        Spacer()
                        Text(isFollowing ? "팔로잉" : "팔로우")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(isFollowing ? AColor.main.color : Color.white)
                            .frame(width: 90.05, height: 27.85)
                            .background(isFollowing ? Color.white : AColor.main.color)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(AColor.main.color, lineWidth: 2))
                            .onTapGesture {
                                isFollowing.toggle()
                                followTapped(tap: isFollowing)
                            }
                    }
                    
                    // 게시물 이미지 (좋아요, 댓글 알림에만 표시)
                    if notification.type == .like || notification.type == .comment,
                       let imageUrl = notification.imageURL {
                        RemoteImage(url: imageUrl)
                            .frame(width: 40, height: 40)
                        
                    }
                }
            }
            
        }
    }
    
    func followTapped(tap: Bool) {
        // (숫자)바꾸면 기본 제공 효과음
        if tap {
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
                output = output + Text(component).foregroundColor(.accentColor)
            } else {
                output = output + Text(component)
            }
        }
        return output
    }
    
    
    
    func styledText(text: String) -> some View {
        var output = AnyView(Text(""))
        let components = text.tokenize("@#. ")
        for component in components {
            if component.rangeOfCharacter(from: CharacterSet(charactersIn: "@#")) != nil {
                output = output + AnyView(Text(component).foregroundColor(.accentColor).onTapGesture {
                    //                    requestAuthNoti()
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    //                        requestSendNoti(seconds: 1)
                    //                    })
                })
            } else {
                output = output + AnyView(Text(component))
            }
        }
        return output
    }
}

struct NotificationsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            NotificationsListView(access: .personal)
                .environmentObject(AlarmViewModel())
        }
    }
}
