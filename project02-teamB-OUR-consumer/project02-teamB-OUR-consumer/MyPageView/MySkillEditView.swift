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
    @State var skillName: String = ""
    @State var description: String = ""
    
    @State var isShowingAlert: Bool = false
    
    @State var skill: [Skill] = [Skill(skillName: "uikit", description: "uikit no jam"),
                                 Skill(skillName: "swiftUi", description: "swiftUI zzang jam")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.top, -10)
                    Group {
                        Text("내 스킬 ") // 폰트 크기랑 굵기 조절필요
                            .padding(.top, 5)
                            .padding(.bottom)
                        
                        HStack {
                            TextField("  스킬을 추가해주세요.", text: $skillName)
                                .overlay(RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.gray, lineWidth: 1.5)
                                    .frame(height: 50))
                            
                            Button {
                                skill.append(Skill(skillName: skillName, description: description))
                                skillName = ""
                                description = ""
                            } label: {
                                Text("추가")
                            }
                            .buttonStyle(.borderless)
                            .alert(isPresented: $isShowingAlert, content: {
                                Alert(title: Text("추가되었습니다."), message: nil, dismissButton: .default(Text("닫기")))
                            })
                            .disabled(skillName.isEmpty || description.isEmpty)

                        }
                        Group {
                            HStack {
                                Text("추가 설명을 입력해 주세요.")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .foregroundColor(.black)
                            
                            TextEditor(text: $description)
                                .frame(height: 170)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1))
                                .padding(.top, -23)
                        }
                        .padding(.vertical)
                    }

                    
                    //                    ScrollView {
                    //                        ForEach(skill) { skill in
                    //                            VStack(alignment: .leading) {
                    //                                Text(skill.skillname)
                    //                                    .font(.headline)
                    //                                    .padding(.vertical)
                    //
                    //                                Text(skill.description)
                    //                                Divider()
                    //                            }
                    //                        }
                    //                    }
                    
                    // 추가 후 표시되도록 하기
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

struct MySkillEditView_Previews: PreviewProvider {
    static var previews: some View {
        MySkillEditView()
    }
}
