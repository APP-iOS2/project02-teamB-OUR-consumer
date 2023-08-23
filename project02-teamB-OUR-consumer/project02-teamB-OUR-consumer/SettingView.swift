//
//  SettingView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

// settingView 는 userDefaults 로 처리?

struct SettingView: View {
    @State var notificationsEnabled: Bool = false
    @State var privacySetting: Bool = false // 스프레드 시트 보기
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                    .padding(.top, 0)
                VStack(alignment: .leading) {
                    Group {
                        Text("계정 설정")
                            .font(.headline)
                            .padding(.bottom)
                        HStack {
                            Text("로그인된 계정")
                            
                            Spacer()
                            Text("lion@gmail.com")
                        }
                        .padding(.vertical, 5)
                        
                        Button {
                            // 비밀번호 변경
                        } label: {
                            Text("비밀번호 변경")
                        }
                        .buttonStyle(.plain)
                        Divider()
                    }
                    
                    Group {
                        HStack {
                            Text("알림 설정")
                                .font(.headline)
                            
                            Toggle(isOn: $notificationsEnabled) {
                                // 상태 변화
                            }
                            .offset(y: 10)
                        }
                        Text("게시물, 추천 알림")
                            .font(.footnote)
                            .padding(.bottom, 10)
                        Divider()
                    }
                    
                    Group {
                        HStack {
                            Text("공개 범위 설정")
                                .font(.headline)
                            Toggle(isOn: $privacySetting) {
                                // 상태 변화
                            }
                            .offset(y: 10)
                        }
                        Text("이력서 공개 여부")
                            .font(.footnote)
                            .padding(.bottom, 10)
                        Divider()
                    }
                    
                    Group {
                        Button {
                            // 문의 뷰
                        } label: {
                            Text("일대일 문의")
                                .font(.headline)
                        }
                        .buttonStyle(.plain)
                        
                        .padding(.vertical)
                        Divider()
                    }
                    
                    Group {
                        Button {
                            // 로그아웃
                        } label: {
                            Text("로그아웃")
                                .font(.headline)
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical)
                        Divider()
                    }

                    Group {
                        Button {
                            // 회원 탈퇴
                        } label: {
                            Text("회원탈퇴")
                                .font(.headline)
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical)
                        Divider()
                    }
                }
                .padding()
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // 뒤로가기
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
