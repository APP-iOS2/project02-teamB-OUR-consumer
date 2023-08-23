//
//  project02_teamB_OUR_consumerApp.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI
import FirebaseCore
import FacebookCore

// 2. AppDelegate 클래스 생성 (따로 파일로 만들어도 됨)
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    // 2-1. 페이스북 사이트에 있는 코드 복붙
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        ApplicationDelegate.shared.application(
//                    application,
//                    didFinishLaunchingWithOptions: launchOptions
//                )
//
//
//        return true
//    }
//
//    // 2-2. SceneDelegate 사용을 위해 추가함
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
//
//        sceneConfiguration.delegateClass = SceneDelegate.self
//
//        return sceneConfiguration
//    }
//}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

      ApplicationDelegate.shared.application(
                  application,
                  didFinishLaunchingWithOptions: launchOptions
              )
      FirebaseApp.configure()
      
      
    return true
  }
    
}

// 3. SceneDelegate 클래스 생성 (따로 파일로 만들어도 됨)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // 3-1. 페이스북 사이트에 있는 코드 복붙
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

}

@main
struct project02_teamB_OUR_consumerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
            }
        }
    }
}
