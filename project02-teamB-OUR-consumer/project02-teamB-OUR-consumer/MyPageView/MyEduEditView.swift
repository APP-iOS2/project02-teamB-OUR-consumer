//
//  MyEduEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

struct MyEduEditView: View {
    @State var schoolNameTextField: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description: String = ""
    
    @State var isPressedBtn: Bool = false
    @State var isSelectedToggle: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, -10)
                    Group {
                        HStack {
                            Text("교육기관 ") // 폰트 크기랑 굵기 조절필요
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
                        }
                        .padding(.top, 5)
                        .padding(.bottom)
                        TextField("  교육기관을 입력해주세요.", text: $schoolNameTextField)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1.5)
                                        .frame(height: 50))
                            
                        // 텍스트필드의 height 넓히기
                    }
                    
                    Group {
                        Text("전공/과정 ") // 폰트 크기랑 굵기 조절필요
                            .padding(.top, 25)
                            .padding(.bottom)
                        
                        TextField("  전공/과정을 입력해주세요.(예: 앱 개발 과정)", text: $schoolNameTextField)
                            .overlay(RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1.5)
                                        .frame(height: 50))
                    }
                    
                    Group {
                        HStack {
                            Text("교육 기간") // 폰트 크기랑 굵기 조절필요
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
                        HStack {
                            if isSelectedToggle {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "square") // 모양 왤ㅋ ㅔ 별로지
                                    Text("재학 중")
                                }
                                .buttonStyle(.plain)
                            } else {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "checkmark.square")

                                    Text("재학 중")
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 5)
                    }
                    Group {
                        if isPressedBtn {
                            Button {
                                isPressedBtn.toggle()
                            } label: {
                                    HStack {
                                        Text("활동을 입력해 주세요.")
                                        Spacer()
                                        Image(systemName: "chevron.up")
                                    }
                                    .foregroundColor(.black)
                                }

                            TextEditor(text: $description)
                                .frame(height: 170)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray, lineWidth: 1))
                                .padding(.top, -23)
                        } else {
                            Button {
                                isPressedBtn.toggle()
                            } label: {
                                HStack {
                                    Text("활동을 입력해 주세요.")
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .foregroundColor(.black)

                            }
                        }

                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                }
                .padding()
            }
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



struct MyEduEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyEduEditView()
        }
    }
}
