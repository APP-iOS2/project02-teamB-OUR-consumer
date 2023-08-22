//
//  project02_teamB_OUR_consumerApp.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct project02_teamB_OUR_consumerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FeedRecruitView()
            }
        }
    }
}
