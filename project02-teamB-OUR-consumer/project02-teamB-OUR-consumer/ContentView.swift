//
//  ContentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1
    var body: some View {
        
        NavigationStack {
            TabView(selection: $selection) {
                //FeedView 팀에서 넣어주시면 됩니다.
                Image(systemName: "house.fill")
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                //StudyFeedView 팀에서 넣어주시면 됩니다.
                Image(systemName: "book.fill")
                    .tabItem {
                        Image(systemName: "book.fill")
                    }
                //RecruitAddView 팀에서 넣어주시면 됩니다.
                Image(systemName: "plus.app.fill")
                    .tabItem {
                        Image(systemName: "plus.app.fill")
                    }
                //AlarmView 팀에서 넣어주시면 됩니다.
                AlarmContainer()
                    .navigationBarTitle("알림", displayMode: .inline)
                    .tabItem {
                        Image(systemName: "bell.fill")
                    }.tag(3)
                //MyPageView 팀에서 넣어주시면 됩니다.
                Image(systemName: "person.fill")
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
            .navigationTitle(selection == 3 ? "알람" : "")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(leading: Button(action: {
//                //FeedView로 돌아가기
//            }, label: {
//                Image("OUR_Logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }))
        }
    }
}


struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
