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
    @State var selectValue: Bool = false
    
    @State var studyText: String = ""
    @State var placeholder: String = "스터디 내용을 입력하세요."
    
    @State var studyCount: Int = 1
    @State var startDate: Date = Date()
    @State var dueDate: Date = Date()
    @State var studyImagePath: [String] = []
    @State var selectedItem: [PhotosPickerItem] = []
    @State var imageDataArray: [Data] = []
    
    
    
    @ObservedObject var sharedViewModel: SharedViewModel = SharedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    // MARK: - 스터디 제목
                    VStack(alignment: .leading)  {
                        Text("스터디 제목")
                            .font(.system(.title3, weight: .semibold))
                        ZStack(alignment: .leading) {
                            if studyTitle.isEmpty {
                                Text("스터디 제목을 입력하세요.")
                                    .foregroundColor(Color.gray)
                                    .padding()
                            }
                            TextField("", text: $studyTitle)
                                .padding() // Adjust the padding as needed
                                .cornerRadius(8) // Customize the corner radius as needed
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }
                    }
                    
                    // MARK: - 스터디 내용
                    VStack(alignment: .leading) {
                        Text("스터디 내용")
                            .font(.system(.title3, weight: .semibold))
                        ZStack{
                            TextEditor(text: $studyText)
                                .frame(minHeight: 180, maxHeight: 180)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                                )
                            
                            if studyText.isEmpty {
                                Text(placeholder)
                                    .foregroundColor(.gray)
                                    .position(x: 104, y: 25)
                            }
                            
                        }
                    }
                    // MARK: - 온/오프라인 선택
                    StudyMeetingView(onlineToggle: $onlineToggle, offlineToggle: $offlineToggle, selectValue: $selectValue)
                    
                    // MARK: - 날짜
                    ButtonMainView(startDate: $startDate, endDate: $dueDate, number: $studyCount)
                    
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
                            
                            if selectedItem.isEmpty {
                                let newStudy = StudyRecruitModel(studyTitle: studyTitle, startAt: startDate.toString(), dueAt: dueDate.toString(), description: studyText, isOnline: selectValue,  locationName: sharedViewModel.selectedLocality, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: sharedViewModel.selectedCoordinates)
                                
                                studyStoreViewModel.addFeed(newStudy)
                                
                            } else {
                                studyImagePath.removeAll()  // 이미지경로 배열 초기화
                                Task {
                                    
                                    self.studyImagePath = try await studyStoreViewModel.returnImagePath(items: selectedItem)
       
                                    
                                    print("추가된 이미지배열 :\n\(studyImagePath)")
                                    
                                    let newStudy = StudyRecruitModel(studyTitle: studyTitle, startAt: startDate.toString(), dueAt: dueDate.toString(), description: studyText, isOnline: selectValue, locationName: sharedViewModel.selectedLocality, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: sharedViewModel.selectedCoordinates)
                                    
                                    studyStoreViewModel.addFeed(newStudy)
                                }
                            }
                            dismiss()
                        }
                        .disabled( studyTitle.isEmpty || studyText.isEmpty )
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            cancel.toggle()
                            dismiss()
                        }
                    }
                }
                
            }.navigationTitle("스터디 등록")
        }
    }
    
}

struct AddStudyMain_Previews: PreviewProvider {
    static var previews: some View {
        //        AddStudyMain(startDate: Date(), endDate: Date(), startTime: Date())
        AddStudyMain()
    }
}

