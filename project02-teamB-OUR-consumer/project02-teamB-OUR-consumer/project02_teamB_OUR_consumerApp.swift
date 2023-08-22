//
//  project02_teamB_OUR_consumerApp.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI

@main
struct project02_teamB_OUR_consumerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IdStore(id: UUID(), name: "이승준", imgString: "JJoon", accountID: "leeseungjun", numberOfPosts: 21, numberOfFollowrs: 50000, numberOfFollowing: 4, briefIntro: "Hi I'm Jjoon"))
        }
    }
}
