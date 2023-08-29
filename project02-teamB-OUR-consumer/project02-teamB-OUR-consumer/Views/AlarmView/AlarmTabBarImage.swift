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
    
    var index: Int
    
     func makeUIView(context: Context) -> AlarmImageContainer {
         print("value: \(selectedIndex)")
         return AlarmImageContainer()
     }
     
     func updateUIView(_ uiView: AlarmImageContainer, context: Context) {
         print("value: \(selectedIndex)")
         
         selectedIndex == index ? uiView.setAlarmImage(color: UIColor.black ) : uiView.setAlarmImage(color: .tertiaryLabel)
         selectedIndex == index ? uiView.setLabel(color: Color(hex: "#090580")) : uiView.setLabel(color: Color.gray)
     }
     
     func makeCoordinator() -> Coordinator { // <-
       Coordinator()
     }
     
     class Coordinator: NSObject { // <-
         
     }
    
}
