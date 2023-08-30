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


    @ObservedObject var resumeViewModel: ResumeViewModel
    
    @State var schoolNameTextField: String = ""
    @State var fieldOfStudy: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var degree = "Degree"
    @State var description: String = ""
  
    @State var isPressedBtn: Bool = false
    @State var isTextFieldEmpty: Bool = false
    @State var isDeleteItemAlert: Bool = false
    
    let degreeOption = ["재학", "휴학", "졸업", "수료"]
    var isEditing: Bool
    var index: Int
    
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
                                   in: startDate..., displayedComponents: [.date])
                        .padding()
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }
                }
                
                Group {
                    
                        Text("재학 중")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.top, 5)
                        
                        Picker("Degree", selection: $degree) {
                            ForEach(degreeOption, id: \.self) {
                                Text($0)
                            }
                        }
                        .frame(width: 130)
                        .accentColor(.black)
                        .background(Color(red: 239/255 , green: 239/255, blue: 240/255))
                        .cornerRadius(7)
                        .padding(.vertical)
                        .offset(x:15)
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
                
                if isEditing {
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
                                resumeViewModel.resume?.education.remove(at: index)
                                resumeViewModel.updateResume()
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
                    if isEditing {
                        saveEduChanges()
                        dismiss()
                    } else {
                        resumeViewModel.resume?.education.append(Education(schoolName: schoolNameTextField, degree: degree, fieldOfStudy: fieldOfStudy, startDate: startDate, endDate: endDate, description: description))
                        resumeViewModel.updateResume()
                        dismiss()
                    }
                    //                        if schoolNameTextField.isEmpty {
                    //                            isTextFieldEmpty.toggle()
                    //                        }
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
        .onAppear(){
            if isEditing {
                guard let education = resumeViewModel.resume?.education[index] else {
                    return
                }
                schoolNameTextField = education.schoolName
                degree = education.degree
                startDate = education.startDate
                endDate = education.endDate ?? Date()
                description = education.description ?? ""
            }
        }
        
      
    }
    func saveEduChanges() {
        guard var resume = resumeViewModel.resume else {
            return
        }
        resume.education[index].schoolName = schoolNameTextField
        resume.education[index].degree = degree
        resume.education[index].startDate = startDate
        resume.education[index].endDate = endDate
        resume.education[index].description = description
        resumeViewModel.updateResume(resume: resume)
    }
}




struct MyEduEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyEduEditView(resumeViewModel: ResumeViewModel(), isEditing: true, index: 0)
        }
    }
}
