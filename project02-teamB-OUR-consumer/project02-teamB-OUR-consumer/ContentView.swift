
//
//  ContentView.swift
//  OURApp
//
//  Created by 박찬호 on 2023/08/22.
//

import SwiftUI


// 주요 색상
let mainColor = Color(red: 9/255, green: 5/255, blue: 128/255)
let defaultGray = Color(red: 215/255, green: 215/255, blue: 215/255)

struct ContentView: View {
    @State private var selectedTab = 0
    // 개인 및 공개 알림 샘플 데이터
    let personalNotifications: [Date: [NotificationItem]] = [
        Date(): [
            NotificationItem(type: .follow, text: "@John_Doe님이 팔로우했습니다.", date: Date(timeIntervalSinceNow: -3 * 3600)),
            NotificationItem(type: .like, text: "@Jane_Smith님이 게시물을 좋아합니다.", date: Date(timeIntervalSinceNow: -2 * 3600)),
            NotificationItem(type: .like, text: "@Tom_Johnson님이 댓글을 남겼습니다.", date: Date(timeIntervalSinceNow: -48 * 3600)),
            NotificationItem(type: .follow, text: "@Emily_Davis님이 팔로우했습니다.", date: Date(timeIntervalSinceNow: -50 * 3600))
        ],
        Calendar.current.date(byAdding: .day, value: -1, to: Date())!: [
            NotificationItem(type: .follow, text: "@Mike_Lee님이 팔로우했습니다.", date: Date(timeIntervalSinceNow: -25 * 3600)),
            NotificationItem(type: .like, text: "@Sarah_Kim님이 게시물을 좋아합니다.", date: Date(timeIntervalSinceNow: -1 * 3600))
        ]
    ]
    let publicNotifications: [Date: [NotificationItem]] = [
        Date(): [
            NotificationItem(type: .studyJoinRequest, text: "@Study_X에 가입 요청했습니다.", date: Date(timeIntervalSinceNow: -1 * 3600)),
            NotificationItem(type: .studyJoinApproval, text: "@Study_Y에 가입이 승인되었습니다.", date: Date(timeIntervalSinceNow: -2 * 3600))
        ],
        Calendar.current.date(byAdding: .day, value: -2, to: Date())!: [
            NotificationItem(type: .studyJoinRequest, text: "@Study_A에 가입 요청했습니다.", date: Date(timeIntervalSinceNow: -50 * 3600)),
            NotificationItem(type: .studyJoinApproval, text: "@Study_B에 가입이 승인되었습니다.", date: Date(timeIntervalSinceNow: -40 * 3600))
        ],
        Calendar.current.date(byAdding: .month, value: -1, to: Date())!: [
            NotificationItem(type: .studyJoinRequest, text: "@Study_C에 가입 요청했습니다.", date: Date(timeIntervalSinceNow: -2592000)),
            NotificationItem(type: .studyJoinApproval, text: "@Study_D에 가입이 승인되었습니다.", date: Date(timeIntervalSinceNow: -2419200))
        ]
    ]

    // 본문 뷰
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 사용자 지정 탭 뷰
                CustomTabView(selectedTab: $selectedTab)
                
                // 알림 뷰
                switch selectedTab {
                case 0:
                    NotificationsListView(notifications: personalNotifications) // 개인 알림
                case 1:
                    NotificationsListView(notifications: publicNotifications) // 공개 알림
                default:
                    Text("알림 뷰")
                }
                
                Spacer()
            }
            .navigationBarTitle("알림", displayMode: .inline)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
