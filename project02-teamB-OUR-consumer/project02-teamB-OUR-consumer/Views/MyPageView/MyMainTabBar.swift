//
//  MyMainTabBar.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/22.
//

import SwiftUI

struct MyMainTabBar: View {
    
    @Binding var currentTab: Int
    @Namespace var namespace
    var tabBarOptions: [String]
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(tabBarOptions.indices, id: \.self) { index in
                let title = tabBarOptions[index]
                TabBarItem(currentTab: $currentTab,
                           namespace: namespace,
                           title: title,
                           tab: index)
            }
        }
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    var title: String
    var tab: Int

    
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack {
                
                if currentTab == tab {
                    Text(title)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.vertical, 10)
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace.self)
                } else {
                    Text(title)
                        .foregroundColor(.gray)
                        .padding(.vertical, 10)
                    Color.gray.frame(height: 2)
                }
            }
            .animation(Animation.easeInOut, value: currentTab)
        }
        .background(.white)
        .buttonStyle(.plain)
        
        
    }
    
}

struct MyMainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MyMainTabBar(currentTab: .constant(0), tabBarOptions: ["이력서", "게시물", "스터디"])
    }
}
