//
//  AddStudyMain.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//

import SwiftUI
import PhotosUI

struct AddStudyMain: View {
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    @StateObject var studyStoreViewModel: StudyRecruitStore = StudyRecruitStore()
    
    @State var studyTitle: String = ""
    @State var addStudy: Bool = false
    @State var cancel: Bool = false
    
    @State var onlineToggle: Bool = false
    @State var offlineToggle: Bool = false
    @State var studyText: String = ""
    @State var placeholder: String = "스터디 내용을 입력해주세요."
    
    @State var studyCount: Int = 1
    @State var startDate: Date = Date()
    @State var dueDate: Date = Date()
    @State var studyImagePath: String = ""
    @State var selectedItem: PhotosPickerItem? = nil

    @ObservedObject var sharedViewModel: SharedViewModel = SharedViewModel()
  
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
                    StudyMeetingView(onlineToggle: $onlineToggle, offlineToggle: $offlineToggle)
                        .padding(.bottom, 20)
                    
                    // MARK: - 날짜
                    Text("날짜와 인원을 선택해주세요.")
                        .font(.title2)
                        .padding(.bottom, 20)

                    ButtonMainView(startDate: $startDate, endDate: $dueDate, number: $studyCount)

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
                    StudyImageView(viewModel: studyStoreViewModel, selectedItem: $selectedItem)
                        
                    
                    // MARK: - 위치 선택
                    StudyMapView(sharedViewModel: sharedViewModel)

                }
                .padding(20)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("등록") {
                            print("등록 버튼 tapped")

                            guard let test = selectedItem else {
                                let newStudy = StudyRecruitModel(creator: "", studyTitle: studyTitle, startAt: startDate, dueAt: dueDate, description: studyText, isOnline: onlineToggle, isOffline: offlineToggle, locationName: sharedViewModel.selectedLocality, reportCount: 0, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: sharedViewModel.selectedCoordinates)
                                studyStoreViewModel.addFeed(newStudy)
                                dismiss()
                                return
                            }
                            
                            studyStoreViewModel.returnImagePath(item: test) { urlString in
                                guard let test = urlString else { return }
                                print("test : \(test)")
                                studyImagePath = test
                                let newStudy = StudyRecruitModel(creator: "", studyTitle: studyTitle, startAt: startDate, dueAt: dueDate, description: studyText, isOnline: onlineToggle, isOffline: offlineToggle, locationName: sharedViewModel.selectedLocality, reportCount: 0, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: sharedViewModel.selectedCoordinates)
                                
                                studyStoreViewModel.addFeed(newStudy)
                            }
                            
                            addStudy.toggle()
                            dismiss()
                        }
                        .disabled(studyTitle.isEmpty || studyText.isEmpty)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            cancel.toggle()
                            print(cancel)
                            print("취소 버튼 tapped")
                            dismiss()
                        }
                    }
                }
                
            }.navigationTitle("스터디 등록")
        }
    }
}

//struct AddStudyMain_Previews: PreviewProvider {
//    static var previews: some View {
//        AddStudyMain(startDate: Date(), endDate: Date(), startTime: Date())
//    }
//}
