//
//  MyCarreerEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

struct MyWorkEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>


    @State var companyName: String = ""
    @State var jobTitle: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var isSelectedToggle: Bool = false
    @State var isEmptyCompanyName: Bool = false
    @State var isEmptyJobTitle: Bool = false
    @State var isDeleteItemAlert: Bool = false
    
    var isShowingDeleteButton: Bool
    
    var body: some View {
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
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top, 5)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isEmptyCompanyName ? .red : .gray, lineWidth: 2)
                            .overlay {
                                TextField("회사명을 입력해주세요.", text: $companyName)
                                    .padding()
                            }
                            .frame(height: 50)
                            .onChange(of: companyName) { newValue in
                                isEmptyCompanyName = newValue.isEmpty
                            }
                    }
                    
                    Group {
                        HStack {
                            Text("직함 ")
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
                        }
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top, 25)
                            
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(isEmptyJobTitle ? .red : .gray, lineWidth: 2)
                                .overlay {
                                    TextField("직함을 입력해주세요.(예: 백엔드 개발자)", text: $jobTitle)
                                        .padding()
                                }
                                .frame(height: 50)
                                .onChange(of: jobTitle) { newValue in
                                    isEmptyJobTitle = newValue.isEmpty
                                }
                    }
                    
                    Group {
                        HStack {
                            Text("재직 기간 ")
                            Text("*")
                                .foregroundColor(.red)
                                .padding(.leading, -10)
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
                            .datePickerStyle(.automatic)
                            
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
                                    Image(systemName: "square")
                                    Text("재직 중")
                                        .font(.system(size: 16))
                                        .bold()
                                }
                                .buttonStyle(.plain)
                            } else {
                                Button {
                                    isSelectedToggle.toggle()
                                    
                                } label: {
                                    Image(systemName: "checkmark.square")
                                    Text("재직 중")
                                        .font(.system(size: 16))
                                        .bold()
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 5)
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: Button(action : {
                                self.mode.wrappedValue.dismiss()
                            }){
                                Image(systemName: "chevron.backward")
                            })
            
                //MARK: 편집일때 삭제하기 뜨도록
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
                }
            }
            .navigationTitle("경력")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if companyName.isEmpty {
                            isEmptyCompanyName.toggle()
                        }
                        if jobTitle.isEmpty {
                            isEmptyJobTitle.toggle()
                        }
                        dismiss()
                    } label: {
                        Text("완료")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(mainColor)
                            .cornerRadius(5)
                    }
                    .disabled(companyName.isEmpty || jobTitle.isEmpty)
                }
                //MARK: Back 버튼 다른 팀이랑 통일
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        // 뒤로가기
//                    } label: {
//                        Image(systemName: "arrow.backward")
//                    }
//
//
//                }
            }
    }
    
}

struct MyCarreerEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyWorkEditView(isShowingDeleteButton: true)
    }
}
