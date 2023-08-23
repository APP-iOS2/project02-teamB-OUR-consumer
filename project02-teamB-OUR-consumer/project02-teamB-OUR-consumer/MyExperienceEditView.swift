//
//  MyExperienceEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

struct MyExperienceEditView: View {
    @State var projectTitle: String = ""
    @State var jobTitle: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, -15)
                    Group {
                        HStack {
                            Text("프로젝트명 ") // 폰트 크기랑 굵기 조절필요
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
                        }
                        .padding(.top, 5)
                        .padding(.bottom)
                        TextField("  프로젝트 직무를 입력해주세요.", text: $projectTitle)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1.5)
                                .frame(height: 50))
                        
                        // 텍스트필드의 height 넓히기
                    }
                    
                    Group {
                        Text("직무명 ") // 폰트 크기랑 굵기 조절필요
                            .padding(.top, 25)
                            .padding(.bottom)
                        
                        TextField("  직무명을 입력해주세요.(예: 앱 개발 과정)", text: $jobTitle)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1.5)
                                .frame(height: 50))
                    }
                    
                    Group {
                        HStack {
                            Text("프로젝트 기간") // 폰트 크기랑 굵기 조절필요
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -7)
                        }
                        .padding(.top, 25)
                        
                        HStack {
                            // 피커 스타일 / 색상 바꾸기 / 크기 바꾸기
                            DatePicker("", selection: $startDate,
                                       displayedComponents: [.date]
                            )
                            .labelsHidden()
                            
                            Text(" ~ ")
                            
                            DatePicker("", selection: $endDate,
                                       displayedComponents: [.date]
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        }
                    }
                    
                    Group {
                        Text("활동을 입력해 주세요.")
                            .padding(.top)
                        TextEditor(text: $description)
                            .frame(height: 170)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1))
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("교육")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 완료 버튼
                    } label: {
                        Text("완료")
                    }
                    .buttonStyle(.bordered)
                    
                }
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


struct MyExperienceEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyExperienceEditView()
    }
}
