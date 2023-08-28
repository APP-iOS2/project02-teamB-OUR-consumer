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
    var tabBarOptions: [String] = ["이력서", "게시물", "스터디"]
    
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

struct MyMainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MyMainTabBar(currentTab: .constant(0))
    }
}
