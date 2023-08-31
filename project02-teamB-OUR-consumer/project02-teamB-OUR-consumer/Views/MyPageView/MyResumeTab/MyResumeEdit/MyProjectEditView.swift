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
    
    @ObservedObject var resumeViewModel: ResumeViewModel
    
    @State var projectTitle: String = ""
    @State var jobTitle: String = ""
    @State var startDate = Date()
    @State var endDate = Date()
    @State var description: String = ""
    
    @State var isTextFieldEmpty: Bool = false
    @State var isDeleteItemAlert: Bool = false
    
    var isEditing: Bool
    var index: Int
    
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
                                   in: startDate..., displayedComponents: [.date])
                        
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
                            resumeViewModel.resume?.projects.remove(at: index)
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
        .navigationTitle("프로젝트")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isEditing {
                        saveProjectChanges()
                        dismiss()
                    } else {
                        resumeViewModel.resume?.projects.append(Project(projectTitle: projectTitle, jobTitle: jobTitle, startDate: startDate, endDate: endDate, description: description))
                        resumeViewModel.updateResume()
                        dismiss()
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
        .onAppear(){
            if isEditing {
                guard let project = resumeViewModel.resume?.projects[index] else {
                    return
                }
                projectTitle = project.projectTitle
                jobTitle = project.jobTitle
                startDate = project.startDate
                endDate = project.endDate ?? Date()
                description = project.description ?? ""
            }
        }
    }
    
    func saveProjectChanges() {
        guard var resume = resumeViewModel.resume else {
            return
        }
        resume.projects[index].projectTitle = projectTitle
        resume.projects[index].jobTitle = jobTitle
        resume.projects[index].startDate = startDate
        resume.projects[index].endDate = endDate
        resume.projects[index].description = description
        resumeViewModel.updateResume(resume: resume)
    }
}


struct MyExperienceEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyProjectEditView(resumeViewModel: ResumeViewModel(), isEditing: false, index: 0)
    }
}
