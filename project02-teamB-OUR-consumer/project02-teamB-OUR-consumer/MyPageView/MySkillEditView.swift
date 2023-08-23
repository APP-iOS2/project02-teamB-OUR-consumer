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

    
    @State var skillName: String = ""
    @State var description: String = ""
    
    @State var isShowingAlert: Bool = false
    @State var isDeleteItemAlert: Bool = false
    
    @State var isChangeItem: Bool = true
    
    @State var skill: [Skill] = [Skill(skillName: "uikit", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                 Skill(skillName: "swiftUi", description: "swiftUI zzang jam")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, -10)
                    Group {
                        Text("내 스킬 ") // 폰트 크기랑 굵기 조절필요
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
                            
                            Button {
                                skill.append(Skill(skillName: skillName, description: description))
                                skillName = ""
                                description = ""
                                isShowingAlert.toggle()
                            } label: {
                                Text("추가")
                            }
                            .buttonStyle(.borderless)
                            // alert가 안되여 ㅠㅠ
                            .alert(isPresented: $isShowingAlert, content: {
                                Alert(title: Text("추가되었습니다."), message: nil, dismissButton: .default(Text("닫기")))
                            })
                            
                            .disabled(skillName.isEmpty)
                            
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
                    
                    Divider()
                        .padding(.vertical)
                    
                    Text("스킬 목록")
                        .font(.system(size: 16))
                        .bold()
                    
                    ForEach(skill) { skill in
                        VStack(alignment: .leading) {
                            Divider()
                            Text(skill.skillName)
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .padding(.vertical, 5)
                            
                            Text(skill.description!)
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                            
                        }
                    }
                    .padding(.bottom)
                    .navigationBarBackButtonHidden(true)
                                .navigationBarItems(leading: Button(action : {
                                    self.mode.wrappedValue.dismiss()
                                }){
                                    Image(systemName: "chevron.backward")
                                })
                
                    
                    if !isChangeItem {
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
 
        }
        //        }
    }
    
}

struct MySkillEditView_Previews: PreviewProvider {
    static var previews: some View {
        MySkillEditView()
    }
}
