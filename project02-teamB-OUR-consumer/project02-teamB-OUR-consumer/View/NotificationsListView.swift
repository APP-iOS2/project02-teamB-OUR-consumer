//
//  NotificationsListView.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI

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
            viewModel.fetchAlarm(access: access)
        }
    }
    func makeListAlarmView(items: NotiItem) -> some View{
        ForEach(items.keys.sorted(by: >),
                id: \.self)
        { key in
           Section(header:
               Text("\(key)")
                   .font(.system(size: 20, weight: .bold))
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
            // 사용자 이미지
            Circle()
                .fill(AColor.defalut.color)
                .frame(width: 40, height: 40)
            
            // 텍스트
            VStack(alignment: .leading) {
<<<<<<< HEAD
=======
                styledText(text: notification.text)
                    .font(.system(size: 15))
>>>>>>> c2173932490cf0e7ba714642294a1a824bae2bb1
                
                styledText(content: notification.content)
                    .font(.system(size: 14))
                Text(DateCalculate().caluculateTime(notification.createdDate.toString()))
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
            }
            
            // 좋아요, 게시글 등 뷰이동할 때
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
            }
            
            // 팔로우/팔로잉 버튼 (해당되는 경우)
            if notification.type == .follow {
                Spacer() // 팔로우 버튼만 오른쪽으로 밀기
                Button(action: {
                    isFollowing.toggle()
                }) {
                    Text(isFollowing ? "팔로잉" : "팔로우")
                        .font(.system(size: 15, weight: .bold)) // 볼드 폰트 적용
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 5)
                        .background(isFollowing ? AColor.defalut.color : AColor.main.color) // 팔로잉 상태에 따른 배경색
                        .cornerRadius(5)
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
<<<<<<< HEAD
    
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
    
=======

            
           
>>>>>>> c2173932490cf0e7ba714642294a1a824bae2bb1
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


<<<<<<< HEAD
struct NotificationsListView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsListView(access: .personal)
            .environmentObject(AlarmViewModel())
    }
}
=======
//struct NotificationsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationsListView(notifications:
//                                [
//                                    Date(): [
//                NotificationItem(type: .follow,
//                                 text: "@JohnDoe 님이 팔로우했습니다.",
//                                 date: Date(timeIntervalSinceNow: -3 * 3600))
//                                    ]
//                               ]
//        )
//    }
//}
>>>>>>> c2173932490cf0e7ba714642294a1a824bae2bb1
