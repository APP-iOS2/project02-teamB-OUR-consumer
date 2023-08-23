//
//  MyCarreerEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

struct MyCarreerEditView: View {
    @State var companyName: String = ""
    @State var jobTitle: String = ""
    
    @State var startDate = Date()
    @State var endDate = Date()
    @State var isSelectedToggle: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, -10)
                    Group {
                        HStack {
                            Text("회사 ")
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
                        }
                        .padding(.top, 5)
                        .padding(.bottom)
                        TextField("  회사명을 입력해주세요.", text: $companyName)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1.5)
                                .frame(height: 50))
                    }
                    
                    Group {
                        HStack {
                            Text("직함 ")
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
                        }
                        .padding(.top, 25)
                        .padding(.bottom)
                        
                        TextField("  직함을 입력해주세요.(예: 백엔드 개발자)", text: $jobTitle)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1.5)
                                .frame(height: 50))
                    }
                    
                    Group {
                        HStack {
                            Text("재직 기간 ")
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
                        }
                        .padding(.top, 25)
                        HStack {
                            // 피커 스타일 / 색상 바꾸기 / 크기 바꾸기
                            DatePicker("", selection: $startDate,
                                       displayedComponents: [.date]
                            )
                            .labelsHidden()
                            .datePickerStyle(.automatic)
                            
                            Text(" ~ ")
                            
                            DatePicker("", selection: $endDate,
                                       displayedComponents: [.date]
                            )
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        }
                        HStack {
                            if isSelectedToggle {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "square") // 모양 왤ㅋ ㅔ 별로지
                                    Text("재직 중")
                                }
                                .buttonStyle(.plain)
                            } else {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "checkmark.square")
                                    Text("재직 중")
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 5)
                    }
                    
                    Spacer()
                    
                }
                .padding()
            }
            .navigationTitle("경력")
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

struct MyCarreerEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyCarreerEditView()
    }
}
