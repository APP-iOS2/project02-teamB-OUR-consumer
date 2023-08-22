//
//  NotificationsListView.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI

// 알림 목록 뷰
struct NotificationsListView: View {
    let notifications: [Date: [NotificationItem]]

    var body: some View {
        List {
            ForEach(notifications.keys.sorted(by: >), id: \.self) { date in
                Section(header: Text(dateString(from: date))
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.black)) { // 날짜 텍스트의 블랙 색상
                    ForEach(notifications[date]!, id: \.text) { notification in
                        NotificationRow(notification: notification)
                    }
                }
            }
        }
        .refreshable {
             // 새로고침 로직
        }
        .listStyle(PlainListStyle()) // 하얀색 배경
    }

    // 날짜를 문자열로 변환
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
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
                .fill(defaultGray)
                .frame(width: 40, height: 40)
            
            // 텍스트
            VStack(alignment: .leading) {
                styledText(text: notification.text)
                    .font(.system(size: 15))
                
                Text(timeSince(notification.date))
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
                        .background(isFollowing ? defaultGray : mainColor) // 팔로잉 상태에 따른 배경색
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

            
           
    func styledText(text: String) -> some View {
        var output = AnyView(Text(""))
        let components = text.tokenize("@#. ")
        for component in components {
            if component.rangeOfCharacter(from: CharacterSet(charactersIn: "@#")) != nil {
                output = output + AnyView(Text(component).foregroundColor(.accentColor).onTapGesture {
                    print("value")
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

    // 알림이 발생한 시간을 문자열로 변환 (예: "3시간 전")
    func timeSince(_ date: Date) -> String {
        let components = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date, to: Date())
        if let years = components.year, years > 0 { return "\(years)년 전" }
        if let months = components.month, months > 0 { return "\(months)달 전" }
        if let days = components.day, days > 0 { return "\(days)일 전" }
        if let hours = components.hour, hours > 0 { return "\(hours)시간 전" }
        if let minutes = components.minute, minutes > 0 { return "\(minutes)분 전" }
        return "방금 전"
    }
}


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
