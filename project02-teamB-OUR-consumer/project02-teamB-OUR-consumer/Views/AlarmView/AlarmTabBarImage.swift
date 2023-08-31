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

        if selectedIndex == index {
            uiView.selected(uicolor: UIColor(named: "AccentColor")!)
        } else {
            uiView.unSelected(color: Color(.tertiaryLabel))
        }
        
        if hasUnreadData {
            uiView.addDot()
        }else {
            uiView.removeDot()
        }
     }
     
     func makeCoordinator() -> Coordinator { // <-
       Coordinator()
     }
     
     class Coordinator: NSObject { // <-
         
     }
    
}
