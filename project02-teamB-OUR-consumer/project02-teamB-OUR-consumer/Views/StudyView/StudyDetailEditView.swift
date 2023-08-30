//
//  StudyDetailEditView.swift
//  project02-teamB-OUR-consumer
//
//  Created by yuri rho on 2023/08/30.
//

import SwiftUI

struct StudyDetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var viewModel: StudyViewModel
    var study: StudyDTO
    
    @State var studyTitle: String = ""
    @State var studyContent: String = ""
    @State var studyMemberCount: Int = 0
    @State var studyDate: Date = Date()
    @State var studyExpireDate: Date = Date()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("스터디 제목")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.vertical, 4)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextField("스터디 제목을 입력하세요", text: $studyTitle)
                                    .padding()
                            }
                            .frame(height: 50)
                        
                        Text("스터디 내용")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.vertical, 4)
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 2)
                            .overlay {
                                TextField("스터디 내용을 입력하세요", text: $studyContent)
                                    .padding()
                            }
                            .frame(minHeight: 200)
                        
                        HStack {
                            Text("모집인원")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.vertical, 4)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                                .overlay {
                                    TextField("", value: $studyMemberCount, formatter: NumberFormatter())
                                        .padding()
                                }
                                .frame(height: 50)
                            Text("명")
                        }
                        
                        Text("스터디 일자")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.vertical, 4)
                        DatePicker(selection: $studyDate) {}
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        
                        Text("게시 만료 일자")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.vertical, 4)
                        DatePicker(selection: $studyDate, displayedComponents: .date) {}
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                Spacer()
                
                
            }
        }
        .navigationTitle("스터디 게시물 수정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.backward")
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    updateStudyFeed()
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
                .buttonStyle(.plain)
            }
        }
        .onAppear {
//            viewModel.makeStudyDetail(study: study) {
//                studyTitle = viewModel.studyDetail.title
//                studyContent = viewModel.studyDetail.description
//                studyMemberCount = viewModel.studyDetail.totalMemberCount
//            }
            studyTitle = viewModel.studyDetail.title
            studyContent = viewModel.studyDetail.description
            studyMemberCount = viewModel.studyDetail.totalMemberCount
        }
    }
    
    func updateStudyFeed() {
        //TODO: 스터디 업데이트
    }
}

struct StudyDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        StudyDetailEditView(viewModel: StudyViewModel(), study: StudyDTO.defaultStudy)
    }
}
