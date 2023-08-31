//
//  MyExperienceEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

struct MyProjectEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    
    @State var projectTitle: String = ""
    @State var jobTitle: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description: String = ""
    
    @State var isTextFieldEmpty: Bool = false
    @State var isDeleteItemAlert: Bool = false
    
    var isShowingDeleteButton: Bool
    
    var body: some View {
        //        NavigationStack {
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
                    .font(.system(size: 16))
                    .bold()
                    .padding(.top, 5)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isTextFieldEmpty ? .red : .gray, lineWidth: 2)
                        .overlay {
                            TextField("프로젝트 직무를 입력해주세요.", text: $projectTitle)
                                .padding()
                                .onChange(of: projectTitle) { newValue in
                                    isTextFieldEmpty = newValue.isEmpty
                                }
                        }
                        .frame(height: 50)
                }
                
                Group {
                    Text("직무명 ") // 폰트 크기랑 굵기 조절필요
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top, 25)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 2)
                        .overlay {
                            TextField("직무명을 입력해주세요.(예: 앱 개발 과정)", text: $jobTitle)
                                .padding()
                        }
                        .frame(height: 50)
                }
                
                Group {
                    HStack {
                        Text("프로젝트 기간")
                        Text("*")
                            .foregroundColor(.red)
                            .padding(.leading, -7)
                    }
                    .font(.system(size: 16))
                    .bold()
                    .padding(.top, 25)
                    
                    HStack {
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
                }
                
                Group {
                    Text("활동을 입력해 주세요.")
                        .font(.system(size: 16))
                        .bold()
                        .padding(.top)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 2)
                        .overlay {
                            TextEditor(text: $description)
                                .padding()
                        }
                        .frame(minHeight: 200)
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
            //MARK: 편집이면 삭제뜨게
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
        .navigationTitle("교육")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if projectTitle.isEmpty {
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
                .disabled(projectTitle.isEmpty)
            }
        }
        //        }
    }
}


struct MyExperienceEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectEditView(isShowingDeleteButton: false)
    }
}
