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
    @EnvironmentObject var studyStoreViewModel: StudyRecruitStore
    @EnvironmentObject var sharedViewModel: SharedViewModel
    
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
    @State var studyImagePath: [String]?
    @State var selectedItem: [PhotosPickerItem] = []
    @State var imageDataArray: [Data] = []
    
    @State var testTime = Double()
    @State var imageProgress = true
//    @ObservedObject var sharedViewModel: SharedViewModel = SharedViewModel()
    @State private var isRegistering = false
    
    var body: some View {
        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 30) {
//                    // MARK: - 스터디 제목
//                    VStack(alignment: .leading)  {
//                        Text("스터디 제목")
//                            .font(.system(.title3, weight: .semibold))
//                        ZStack(alignment: .leading) {
//                            if studyTitle.isEmpty {
//                                Text("스터디 제목을 입력하세요.")
//                                    .foregroundColor(Color.gray)
//                                    .padding()
//                            }
//                            TextField("", text: $studyTitle)
//                                .padding()
//                                .cornerRadius(8)
//                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
//                        }
//                    }
//
//                    // MARK: - 스터디 내용
//                    VStack(alignment: .leading) {
//                        Text("스터디 내용")
//                            .font(.system(.title3, weight: .semibold))
//                        ZStack{
//                            TextEditor(text: $studyText)
//                                .frame(minHeight: 180, maxHeight: 180)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
//                                )
//
//                            if studyText.isEmpty {
//                                Text(placeholder)
//                                    .foregroundColor(.gray)
//                                    .position(x: 104, y: 25)
//                            }
//
//                        }
//                    }
//                    // MARK: - 온/오프라인 선택
//                    StudyMeetingView(onlineToggle: $onlineToggle, offlineToggle: $offlineToggle, selectValue: $selectValue)
//
//                    // MARK: - 날짜
//                    ButtonMainView(startDate: $startDate, endDate: $dueDate, number: $studyCount)
//
//                    // MARK: - 사진 선택
////                    StudyImageView(viewModel: studyStoreViewModel, selectedItem: $selectedItem)
//                    StudyImageView(selectedItem: $selectedItem)
//
//                    // MARK: - 위치 선택
////                    StudyMapView(sharedViewModel: sharedViewModel)
//                    StudyMapView()
//
//                }
//                .padding(20)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//
//                        Button("등록") {
//                            print("등록 버튼 tapped")
//
//
////                            dismiss()
//                        }
//                        .disabled( studyTitle.isEmpty || studyText.isEmpty )
//
//                    }
//                }

            ScrollView {
                ZStack {
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
                                    .padding()
                                    .cornerRadius(8)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                            }
                        }
                        
                        // MARK: - 스터디 내용
                        VStack(alignment: .leading) {
                            Text("스터디 내용")
                                .font(.system(.title3, weight: .semibold))
                            ZStack(alignment: .top) {
                                TextEditor(text: $studyText)
                                    .frame(minHeight: 180)
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
                        StudyImageView(selectedItem: $selectedItem)
                        
                        // MARK: - 위치 선택
                        StudyMapView()

                    }
                    
                   
                }
                .padding(20)
                .toolbar {
                    Button("등록") {
                        registerStudy()
                    }
                    .disabled(studyTitle.isEmpty || studyText.isEmpty || isRegistering)
                }
            .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            cancel.toggle()
                            dismiss()
                        }
                    }
                }
                
            }
            .overlay(content: {
                if isRegistering {
                    ProgressView("등록 중")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.secondary.opacity(0.5))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            })
            .navigationTitle("스터디 등록")
        }
    }
    
    func registerStudy() {
        isRegistering = true
        
        if selectedItem.isEmpty {
            let newStudy = StudyRecruitModel(studyTitle: studyTitle, startAt: startDate.toString(), dueAt: dueDate.toString(), description: studyText, isOnline: selectValue, locationName: sharedViewModel.selectedLocality, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: sharedViewModel.selectedCoordinates)
            
            studyStoreViewModel.addFeed(newStudy)
            
            // Registration completed, reset the flag
            isRegistering = false
            dismiss()
        } else {
            let startTime = Date()
            Task {
                self.studyImagePath = try await studyStoreViewModel.returnImagePath(items: selectedItem)
                print("추가된 이미지배열 : \(String(describing: studyImagePath))")
                let endTime = Date()
                
                let newStudy = StudyRecruitModel(studyTitle: studyTitle, startAt: startDate.toString(), dueAt: dueDate.toString(), description: studyText, isOnline: selectValue, locationName: sharedViewModel.selectedLocality, studyImagePath: studyImagePath, studyCount: studyCount, studyCoordinates: sharedViewModel.selectedCoordinates)
                
                testTime = endTime.timeIntervalSince(startTime)
                print("testTime \(testTime)")
                studyStoreViewModel.addFeed(newStudy)
                
                // Registration completed, reset the flag
                isRegistering = false
                dismiss()
            }
        }
    }
    
}

struct AddStudyMain_Previews: PreviewProvider {
    static var previews: some View {
        AddStudyMain()
            .environmentObject(StudyRecruitStore())
            .environmentObject(SharedViewModel())
    }
}

