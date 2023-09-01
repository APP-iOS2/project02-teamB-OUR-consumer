//
//  CustomTabBarView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct CustomTabBarView: View {


    @StateObject var model = CustomTabBarViewModel()  //여기서만 씁니다.
    
    @StateObject var alarmViewModel = AlarmViewModel(dependency: .init(alarmFireSerivce: AlarmFireService()))
    @StateObject var userViewModel = UserViewModel()
    @StateObject var studyViewModel = StudyViewModel()
    @StateObject var resumeViewModel = ResumeViewModel()
    

    @State private var selectedIndex = 0
    @State var isShowingSheet: Bool = false


    let tabBarImageNames = ["house.fill",  "book.fill", "plus.app", "bell.fill", "person.fill"]
    let tabBarTextNames = ["피드", "스터디", "", "알림", "프로필"]
    
    @State private var isReportPresent = false
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    FeedTabView()
                case 1:
                    StudyListView()
                        .environmentObject(userViewModel)
                        .environmentObject(studyViewModel)
                case 2:
                    RecruitMainSheet(isShowingSheet: $isShowingSheet)
                case 3:
                    AlarmContainer()
                        .environmentObject(alarmViewModel)
                        
                case 4:
                    MyMain()
                        .environmentObject(userViewModel)
                        .environmentObject(studyViewModel)
                        .environmentObject(resumeViewModel)
                default:
                    EmptyView()
                }
            }

            Spacer()
            
            ZStack {
                
                Rectangle()
                    .frame(height: 55)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
//                    .shadow(radius: 8)
                    .padding(.horizontal, 10)
                    .overlay(alignment: .top) {
                        Divider()
                            .background(Color("DefaultGray"))
                    }
                    

                HStack {
                    Spacer()
                    
                    ForEach(0 ..< tabBarImageNames.endIndex, id:\.self) { index in
                        VStack {
                            if index == 2 {
                                VStack {
                                    Button {
                                        //신고누적횟수가 3회초과했을 경우 등록을 못하게 막음.
                                        if model.reportCount < 4 {
                                            isShowingSheet.toggle()
                                        } else {
                                            isReportPresent.toggle()
                                        }
                                    } label: {
                                        PostButton()
                                    }
                                    .alert("알림", isPresented: $isReportPresent) {
                                        EmptyView()
                                    } message: {
                                        Text("신고 누적횟수가 \(model.reportCount)회 입니다.\n게시물관련 등록기능을 이용하실 수 없습니다.\n관리자에게 문의바랍니다.")
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
                                    if tabBarImageNames[index] == "bell.fill" {
                                        AlarmTabBarImage(selectedIndex: $selectedIndex, hasUnreadData: $alarmViewModel.hasUnreadData, index: index)
                                        .frame(width: 20, height: 35, alignment: .bottom)
                                        
                                    }
                                    else {
                                        Image(systemName: tabBarImageNames[index])
                                            .font(.system(size: 22, weight: .light))
                                            .foregroundColor(selectedIndex == index ? Color(hex: "#090580") : Color(hex: "#a6a6a6"))
                                        
                                        Text("\(tabBarTextNames[index])")
                                            .font(.system(size: 14))
                                            .foregroundColor(selectedIndex == index ? Color(hex: "#090580") : Color(.tertiaryLabel))
                                            
                                        

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
                .offset(y:10)
                
                
            }
            .onAppear {
                model.getReportCount()
            }
            
        }.navigationBarBackButtonHidden()
            
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}
