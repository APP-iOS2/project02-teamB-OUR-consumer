
//
//  ContentView.swift
//  OURApp
//
//  Created by 박찬호 on 2023/08/22.
//

import SwiftUI



struct AlarmContainer: View {
    
    @EnvironmentObject var viewModel: AlarmViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var selectedTab = 0
    
    @State private var allClearAlertShowing = false
    let alertTitle: String = "알림 전체 삭제"
    
    // 본문 뷰
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 사용자 지정 탭 뷰
                CustomTabView(selectedTab: $selectedTab)
                
                // 알림 뷰
                switch selectedTab {
                case 0:
                    NotificationsListView(access: .personal) // 개인 알림
                       
                case 1:
                    NotificationsListView(access: .public) // 공개 알림
                       
                default:
                    Text("알림 뷰")
                }
                Spacer()
            }
        }
        .onAppear{
            viewModel.fetchNotificationItem()
            viewModel.markAllAsRead()
        }
        .navigationTitle("알림")
        .navigationBarTitleDisplayMode(.inline)
        
        // 전체 삭제
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    allClearAlertShowing = true
                } label: {
                    Label("전체 삭제", systemImage: "trash.fill")
                }
                .foregroundColor(.black)
                .font(.system(size: 14, weight: .medium))
                .alert(
                    isPresented: $allClearAlertShowing
                ) {
                    Alert(
                        title: Text(alertTitle),
                        primaryButton: .destructive(Text("삭제")) {
                            viewModel.personalNotiItem = [:]
                            viewModel.publicNotiItem = [:]
                        },
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
        }
    }
}



struct AlarmContainer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AlarmContainer()
                .environmentObject(AlarmViewModel(dependency: .init(alarmFireSerivce: AlarmFireService())))
        }
    }
}
