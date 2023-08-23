//
//  ContentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            //FeedView 팀에서 넣어주시면 됩니다.
            NavigationStack {
                Image(systemName: "house.fill")
                    .navigationBarItems(leading: Button(action: {
                        //FeedView로 돌아가기
                    }, label: {
                        Image("OUR_Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }))
            }
            
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
            Image(systemName: "bell.fill")
                .tabItem {
                    Image(systemName: "bell.fill")
                }
            //MyPageView 팀에서 넣어주시면 됩니다.
            MyResumeView()
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
