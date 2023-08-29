//
//  MySkillEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 변상필 on 2023/08/22.
//

import SwiftUI

//struct Skill: Identifiable {
//    var id: String = UUID().uuidString
//    var skillname: String
//    var description: String
//
//}

struct MySkillEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var resumeViewModel: ResumeViewModel
    
    @State var skillName: String = ""
    @State var description: String = ""
    
    @State var isShowingAlert: Bool = false
    @State var isDeleteItemAlert: Bool = false
    
    var isEditing: Bool
    var index: Int
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, -10)
                    Group {
                        Text("내 스킬") // 폰트 크기랑 굵기 조절필요
                            .font(.system(size: 16))
                            .bold()
                            .padding(.top, 5)
                            .padding(.bottom)
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                                .overlay {
                                    TextField("스킬을 추가해주세요.", text: $skillName)
                                        .padding()
                                }
                                .frame(height: 50)
                            
//                            Button {
//                                //스킬추가
//                                skillName = ""
//                                description = ""
//                                isShowingAlert.toggle()
//                            } label: {
//                                Text("추가")
//                            }
//                            .buttonStyle(.borderless)
//                            // alert가 안되여 ㅠㅠ
//                            .alert(isPresented: $isShowingAlert, content: {
//                                Alert(title: Text("추가되었습니다."), message: nil, dismissButton: .default(Text("닫기")))
//                            })
//                            .disabled(skillName.isEmpty)
                            
                        }
                        Group {
                            HStack {
                                Text("추가 설명을 입력해 주세요.")
                                    .font(.system(size: 16))
                                    .bold()
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.black)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                                .overlay {
                                    TextEditor(text: $description)
                                        .padding()
                                }
                                .frame(height: 200)
                        }
                        .padding(.top)
                    }
                    
                    //MARK: 편집일 때 삭제하기 뜨도록
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
                                    resumeViewModel.resume?.skills.remove(at: index)
                                    resumeViewModel.updateResume()
                                    dismiss()
                                }), secondaryButton: .cancel(Text("취소")))
                            }
                            Spacer()
                        }
                    }
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
        }
        .navigationTitle("스킬")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isEditing {
                        saveSkillChanges()
                        dismiss()
                    } else {
                        resumeViewModel.resume?.skills.append(Skill(skillName: skillName, description: description))
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
            }
        }
        .onAppear {
            if isEditing {
                if let skill = resumeViewModel.resume?.skills[index] {
                    skillName = skill.skillName
                    description = skill.description ?? ""
                }
            }
        }
    }
    
    func saveSkillChanges() {
        if var updatedResume = resumeViewModel.resume {
            updatedResume.skills[index].skillName = skillName
            updatedResume.skills[index].description = description
            resumeViewModel.updateResume(resume: updatedResume)
        }
    }
}

struct MySkillEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MySkillEditView(resumeViewModel: ResumeViewModel(), isEditing: false, index: 0)
        }
    }
}
