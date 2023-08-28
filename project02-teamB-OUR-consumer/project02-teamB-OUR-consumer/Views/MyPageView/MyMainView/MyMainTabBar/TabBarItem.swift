//
//  TabBarItem.swift
//  project02-teamB-OUR-consumer
//
//  Created by 이희찬 on 2023/08/26.
//

import SwiftUI

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
                Text(title)
                    .foregroundColor(currentTab == tab ? .black : .gray)
                    .bold()
                    .padding(.vertical, 10)
                Color(currentTab == tab ? .black : .gray)
                    .frame(height: 2)
            }
            .animation(.none, value: currentTab)
        }
        .background(.white)
        .buttonStyle(.plain)
    }
}

struct TabBarItem_Previews: PreviewProvider {
    @Namespace static var testNamespace
    
    static var previews: some View {
        Group {
            TabBarItem(currentTab: .constant(0), namespace: testNamespace, title: "이력서", tab: 0)
            TabBarItem(currentTab: .constant(1), namespace: testNamespace, title: "게시물", tab: 1)
            TabBarItem(currentTab: .constant(2), namespace: testNamespace, title: "스터디", tab: 2)
        }
        .previewLayout(.sizeThatFits)
    }
}

