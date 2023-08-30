//
//  MyFollowView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/28.
//

import SwiftUI

struct MyFollowView: View {
    
    @State var currentTab: Int
    @ObservedObject var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    switch currentTab {
                    case 0:
                        MyFollowerView(userViewModel: userViewModel)
                    case 1:
                        MyFollowingView(userViewModel: userViewModel)
                    default:
                        EmptyView()
                    }
                } header: {
                    MyMainTabBar(currentTab: $currentTab, namespace: Namespace(), tabBarOptions: ["팔로워", "팔로잉"])
                }
            }
            
        }
        .navigationBarTitle("\(userViewModel.user?.name ?? "")")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        
    }
}

struct MyFollowView_Previews: PreviewProvider {
    static var previews: some View {
        MyFollowView(currentTab: 0, userViewModel: UserViewModel())
    }
}
