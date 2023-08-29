//
//  AlarmTabBarImage.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/25.
//

import SwiftUI
//
//
struct AlarmTabBarImage: UIViewRepresentable{
    @Binding var selectedIndex: Int
    @Binding var hasUnreadData: Bool
    
    var index: Int
    
     func makeUIView(context: Context) -> AlarmImageContainer {
         print("value: \(selectedIndex)")
         return AlarmImageContainer()
     }
     
    func updateUIView(_ uiView: AlarmImageContainer, context: Context) {
         print("value: \(selectedIndex)")

         
         selectedIndex == index ? uiView.settingColor(color: UIColor(named: "AccentColor")!) : uiView.settingColor(color: .tertiaryLabel)
         selectedIndex == index ? uiView.settingColor(color: Color(uiColor: UIColor(named: "AccentColor")!)) : uiView.settingColor(color: Color.gray)
         
        if hasUnreadData {
            print("뱃지 생김")  // 디버깅 코드
            uiView.addDot()
        }else {
            print("뱃지 없어짐")  // 디버깅 코드
            uiView.removeDot()
        }
     }
     
     func makeCoordinator() -> Coordinator { // <-
       Coordinator()
     }
     
     class Coordinator: NSObject { // <-
         
     }
    
}
