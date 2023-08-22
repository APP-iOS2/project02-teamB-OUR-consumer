//
//  ContentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        self.init(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0
        )
    }
}

struct ContentView: View {
    @State var mainLogoToggle: Bool = true
    
    let hexColor: String = "#090580" //메인컬러로 변경
    
    var body: some View {
        NavigationStack {
            TabView {
                //FeedView 팀에서 넣어주시면 됩니다.
                Image(systemName: "house.fill")
                    .tabItem {
                        Label("피드", systemImage: "house.fill")
                    }
                //StudyFeedView 팀에서 넣어주시면 됩니다.
                Image(systemName: "book.fill")
                    .tabItem {
                        Label("스터디모집", systemImage: "book.fill")
                    }
                //RecruitAddView 팀에서 넣어주시면 됩니다.
                Image(systemName: "plus.app.fill")
                    .tabItem {
                        Label("작성하기", systemImage: "plus.app.fill")
                    }
                //AlarmView 팀에서 넣어주시면 됩니다.
                Image(systemName: "bell.fill")
                    .tabItem {
                        Button {
                            mainLogoToggle = false
                            print(mainLogoToggle)
                        } label: {
                            Label("알림", systemImage: "bell.fill")
                        }
                    }
                //MyPageView 팀에서 넣어주시면 됩니다.
                Image(systemName: "person.fill")
                    .tabItem {
                        Label("마이페이지", systemImage: "person.fill")
                    }
            }
            .tint(Color(hex: hexColor)) // 메인컬러로 변경
            .navigationBarItems(leading: Button(action: {
                //FeedView로 돌아가기
            }, label: {
                if mainLogoToggle == false {
                    
                } else {
                    Image("OUR_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
