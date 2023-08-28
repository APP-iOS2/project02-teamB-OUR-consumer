//
//  CustomTabBarView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct CustomTabBarView: View {
    @State private var selectedIndex = 0
    @State var isShowingSheet: Bool = false
    let tabBarImageNames = ["house.fill",  "book.fill", "plus.app", "bell.fill", "person.fill"]
    let tabBarTextNames = ["피드", "스터디", "", "알림", "마이페이지"]
    
    var body: some View {
        VStack {
            ZStack {
                if selectedIndex == 0 {
                    FeedTabView()
                } else if selectedIndex == 1 {
                    StudyListView()
                } else if selectedIndex == 2 {
                    RecruitMainSheet(isShowingSheet: $isShowingSheet)
                } else if selectedIndex == 3 {
                    AlarmContainer()
                } else if selectedIndex == 4 {
                    MyMain()
                } else {
                    
                }
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 45)
                //                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 15)
                HStack {
                    Spacer()
                    //                    0 ..< tabBarImageNames.count
                    ForEach(0 ..< tabBarImageNames.endIndex, id:\.self) { index in
                        VStack {
                            if index == 2 {
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
                                VStack {
                                    if tabBarImageNames[index] == "bell.fill"{
                                        AlarmTabBarImage(selectedIndex: $selectedIndex, index: index)
                                            .frame(width: 30, height: 45, alignment: .bottom)
                                    }else{
                                        Image(systemName: tabBarImageNames[index])
                                            .font(.system(size: 20, weight: .light))
                                            .foregroundColor(selectedIndex == index ? Color(.black) : Color(.tertiaryLabel))
                                        
                                        Text("\(tabBarTextNames[index])")
                                            .font(.system(size: 14))
                                            .foregroundColor(selectedIndex == index ? Color(hex: "#090580") : .gray)
                                    }
                                }
                            }
                        }
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    selectedIndex = index
                                }
                        )
                        Spacer()
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}
