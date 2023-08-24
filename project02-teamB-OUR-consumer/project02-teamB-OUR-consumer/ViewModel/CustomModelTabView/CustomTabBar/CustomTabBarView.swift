//
//  CustomTabBarView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/24.
//

import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedIndex = 0
    @State var isShowingSheet: Bool = false
    let tabBarImageNames = ["house",  "book", "plus.app", "bell", "person"]
    
    var body: some View {
        VStack {
            ZStack {
                if selectedIndex == 0 {
//                    FeedTabView()
                } else if selectedIndex == 1 {
//                    StudyListView()
                } else if selectedIndex == 2 {
                    RecruitMainSheet(isShowingSheet: $isShowingSheet)
                } else if selectedIndex == 3 {
//                    AlarmContainer()
                } else if selectedIndex == 4 {
//                    MyMain()
                } else {
                    
                }
            }
            
            Spacer()
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 45)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 15)
                HStack {
                    Spacer()
//                    0 ..< tabBarImageNames.count
                    ForEach(0 ..< tabBarImageNames.endIndex) { image in
                        VStack {
                            if image == 2 {
                                VStack {
                                    Button {
                                        isShowingSheet.toggle()
                                    } label: {
                                        PostButton()
                                    }
                                }
                                
                                .sheet(isPresented: $isShowingSheet) {
                                    print("dismissed")
                                } content: {
                                    RecruitMainSheet(isShowingSheet: $isShowingSheet)
                                        .presentationDetents([.fraction(0.45)])
                                        .presentationDragIndicator(.visible)
                                }
                                
                            } else {
                                Image(systemName: tabBarImageNames[image])
                                    .font(.system(size: 20, weight: .light))
                                    .foregroundColor(selectedIndex == image ? Color(.black) : Color(.tertiaryLabel))
                            }
                        }
                        
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    selectedIndex = image
                                }
                        )
                        Spacer()
                    }
                }
            }
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}
