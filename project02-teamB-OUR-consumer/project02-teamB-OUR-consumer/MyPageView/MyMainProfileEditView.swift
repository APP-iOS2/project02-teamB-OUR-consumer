//
//  MyMainProfileEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/22.
//

import SwiftUI

struct MyMainProfileEditView: View {
    
    @State var username: String
//    @State var profileMessage: String
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        ZStack(alignment: .bottomTrailing) {
                            Image("OUR_Logo")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(60)
                            
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(mainColor) // 이미지 색상 설정
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 2) // 원형 보더 설정
                                    )
                                    
                            }
                            
                            
                        }
                        .padding(.vertical)
                    
                        Spacer()
                        
                    }
                    
                    
                
                    VStack(alignment: .leading, spacing: 8) {
                        Text("이름")
                            .bold()
                            .padding(.vertical, 4)
                            
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextField("이름을 입력해주세요.", text: $username)
                                    .padding()
                                    
                            }
                            .frame(height: 50)
                    }
                    .padding(.vertical)
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("자기소개")
                            .bold()
                            .padding(.vertical, 4)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextEditor(text: $username)
                                    .padding()
                            }
                            .frame(minHeight: 300)
                    }
                    .padding(.vertical)
                
                
                }
                .padding(.horizontal)
                
                
                
                Spacer()
                
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: 프로필 편집
                } label: {
                    Text("완료")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.black)
                        .cornerRadius(5)
                    
                }
                .buttonStyle(.plain)

            }
        })
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyMainProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MyMainProfileEditView(username: "하이")
        }
    }
}
