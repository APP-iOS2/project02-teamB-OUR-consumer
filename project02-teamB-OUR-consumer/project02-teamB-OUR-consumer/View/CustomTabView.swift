//
//  CustomTabButton.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI



// 사용자 지정 탭 뷰
struct CustomTabView: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            CustomTabButton(selectedTab: $selectedTab, text: "깔깔", index: 0)
            CustomTabButton(selectedTab: $selectedTab, text: "근엄", index: 1)
        }
        .padding(.horizontal)
        .font(.system(size: 16, weight: .semibold))
    }
}


// 사용자 지정 탭 버튼
struct CustomTabButton: View {
    @Binding var selectedTab: Int
    let text: String
    let index: Int

    var body: some View {
        VStack {
            Button(action: { selectedTab = index }) {
                Text(text)
                    .fontWeight(.bold)
                    .foregroundColor(selectedTab == index ? Color.black : defaultGray) // 선택된 탭은 블랙, 그 외는 회색
            }
            if selectedTab == index {
                mainColor.frame(height: 2) // 강조선
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(selectedTab: .constant(1))
    }
}
