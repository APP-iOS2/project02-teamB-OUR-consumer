//
//  UNNotificationCenter.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/23.
//

import SwiftUI


class UNNotificationService{
    
    static var shared = UNNotificationService()
    
    private let userNotiCenter = UNUserNotificationCenter.current()
    
    private init(){}
    
    // 사용자에게 알림 권한 요청
    func requestAuthNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, error) in
            if let error = error {
                print(#function, error)
            }
        }
    }
    
    // 알림 전송
    func requestSendNoti(seconds: Double ,type: NotificationType = .none, body: String = "장수지님이 팔로잉 했습니다.") {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "\(type.value)"
        notiContent.body = "\(body)"
        notiContent.userInfo = ["targetScene": "splash"] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        
        userNotiCenter.add(request) { (error) in
            print(#function, error)
        }
    }
}
