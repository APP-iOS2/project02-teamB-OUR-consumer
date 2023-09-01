//
//  project02_teamB_OUR_consumerApp.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        /*-----------------------------------
            FireBase 에뮬레이터 사용시 주석 제거
         ----------------------------------*/
        //스토리지
        Storage.storage().useEmulator(withHost:"127.0.0.1", port:9199)
        
        //인증관련
//        Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099)
        
        //파이어스토어
        let settings = Firestore.firestore().settings
        settings.host = "127.0.0.1:8080"
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner,.list,.sound])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // deep link처리 시 아래 url값 가지고 처리
        _ = response.notification.request.content.userInfo
        
        completionHandler()
    }
}


@main
struct project02_teamB_OUR_consumerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sharedViewModel = SharedViewModel()
//    @StateObject var alarmViewModel = AlarmViewModel()
    @StateObject var feedStoreViewModel = FeedRecruitStore()        //피드  등록모델
    @StateObject var studyStoreViewModel = StudyRecruitStore()      //스터디 등록모델

    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
            }
//            .environmentObject(alarmViewModel)
            .environmentObject(feedStoreViewModel)
            .environmentObject(studyStoreViewModel)
            .environmentObject(sharedViewModel)

        }
    }
}
