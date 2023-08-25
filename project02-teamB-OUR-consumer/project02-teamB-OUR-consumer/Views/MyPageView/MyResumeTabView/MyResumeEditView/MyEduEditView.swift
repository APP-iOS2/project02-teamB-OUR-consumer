//
//  MyEduEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

struct MyEduEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>


    
    @State var schoolNameTextField: String = ""
    @State var fieldOfStudy: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description: String = ""
    
    @State var isPressedBtn: Bool = false
    @State var isSelectedToggle: Bool = false
    @State var isTextFieldEmpty: Bool = false
    @State var isDeleteItemAlert: Bool = false
    var isShowingDeleteButton: Bool
    
    var body: some View {
//        NavigationStack {
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
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top, 5)

                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isTextFieldEmpty ? .red : .gray, lineWidth: 2)
                            .overlay {
                                TextField("교육기관을 입력해주세요.", text: $schoolNameTextField)
                                    .padding()
                                    .onChange(of: schoolNameTextField) { newValue in
                                        isTextFieldEmpty = newValue.isEmpty
                                    }
                            }
                            .frame(height: 50)
                    }
                    
                    Group {
                        Text("전공/과정 ") // 폰트 크기랑 굵기 조절필요
                            .font(.system(size: 16))
                            .bold()
                            .padding(.top, 25)

                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextField("전공/과정을 입력해주세요.(예: 앱 개발 과정)", text: $fieldOfStudy)
                                    .padding()
                            }
                            .frame(height: 50)
                    }
                    
                    Group {
                        HStack {
                            Text("교육 기간") // 폰트 크기랑 굵기 조절필요
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -7)
                        }
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top, 25)
                        
                        HStack {
                            // 피커 스타일 / 색상 바꾸기 / 크기 바꾸기
                            DatePicker("", selection: $startDate,
                                       displayedComponents: [.date]
                            )
                            .padding()
                            .labelsHidden()
                            
                            Text(" ~ ")
                            
                            DatePicker("", selection: $endDate,
                                       displayedComponents: [.date]
                            )
                            .padding()
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        }
                        HStack {
                            if !isSelectedToggle {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "square") // 모양 왤ㅋ ㅔ 별로지
                                    Text("재학 중")
                                        .font(.system(size: 16))
                                        .bold()
                                }
                                .buttonStyle(.plain)
                            } else {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "checkmark.square")

                                    Text("재학 중")
                                        .font(.system(size: 16))
                                        .bold()
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
                                            .font(.system(size: 16))
                                            .bold()
                                        Spacer()
                                        Image(systemName: "chevron.up")
                                    }
                                    .foregroundColor(.black)
                                }

                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                                .overlay {
                                    TextEditor(text: $description)
                                        .padding()
                                }
                                .padding(.top, 0)
                                .frame(minHeight: 250) 
                        } else {
                            Button {
                                isPressedBtn.toggle()
                            } label: {
                                HStack {
                                    Text("활동을 입력해 주세요.")
                                        .font(.system(size: 16))
                                        .bold()
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .foregroundColor(.black)

                            }
                        }
                    }
                    .padding(.vertical)
                    .padding(.bottom, 15)
                    .navigationBarBackButtonHidden(true)
                                .navigationBarItems(leading: Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                })
                
                    if isShowingDeleteButton {
                        HStack{
                            Spacer()
                            Button {
                                isDeleteItemAlert.toggle()
                            } label: {
                                Text("삭제하기")
                                    .font(.system(size: 12))
                                    .fontWeight(.semibold)
                                
                            }
                            .foregroundColor(.gray)
                            .alert(isPresented: $isDeleteItemAlert) {
                                Alert(title: Text("삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제"), action: {
                                    //삭제 함수
                                    dismiss()
                                }), secondaryButton: .cancel(Text("취소")))
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    
                }
                .padding()
            }
            .navigationTitle("교육")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if schoolNameTextField.isEmpty {
                            isTextFieldEmpty.toggle()
                        }
                    } label: {
                        Text("완료")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(mainColor)
                            .cornerRadius(5)
                    }
                    .disabled(schoolNameTextField.isEmpty)
                }

            }
//        }
    }
}



struct MyEduEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyEduEditView(isShowingDeleteButton: false)
        }
    }
}
