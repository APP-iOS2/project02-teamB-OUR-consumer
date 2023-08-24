//
//  AddStudyMain.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//

import SwiftUI

struct AddStudyMain: View {
    
    @State var studyTitle: String = ""
    @State var addStudy: Bool = false
    @State var cancel: Bool = false
    
    @State var onlineToggle: Bool = false
    @State var offlineToggle: Bool = false
    @State var studyText: String = ""
    @State var placeholder: String = "스터디 내용을 입력해주세요."
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // MARK: - 스터디 제목
                    Text("스터디 제목을 입력해주세요.").font(.system(.title2))
                    TextField(" 스터디 제목을 입력하세요.", text: $studyTitle)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom, 20)
                    
                    // MARK: - 온/오프라인 선택
                    MeetingFormView(onlineToggle: $onlineToggle, offlineToggle: $offlineToggle)
                        .padding(.bottom, 20)
                    
                    // MARK: - 날짜
                    Text("날짜와 인원을 선택해주세요.")
                        .font(.title2)
                        .padding(.bottom, 20)
                    ZStack {
                        ButtonMainView(startDate: Date(), endDate: Date())
                    }
                    
                    // MARK: - 스터디 내용
                    Text("스터디 내용을 입력해주세요.")
                        .font(.system(.title2))
                    ZStack{
                        TextEditor(text: $studyText)
                            .frame(minHeight:350, maxHeight:350)
                            .border(.gray)
                        

                        
                        
                        if studyText.isEmpty {
                            Text(placeholder)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // MARK: - 사진 선택
                    StudyImageView()
                        .padding(.bottom, 20)
                    
                    // MARK: - 위치 선택
                    StudyMapView()
    
                }
                .padding(20)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("추가") {
                            addStudy.toggle()
                            print(addStudy)
                            print("추가 버튼 tapped")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            cancel.toggle()
                            print(cancel)
                            print("취소 버튼 tapped")
                        }
                    }
                }
            }.navigationTitle("스터디 등록")
        }
    }
}

struct AddStudyMain_Previews: PreviewProvider {
    static var previews: some View {
        AddStudyMain()
    }
}
