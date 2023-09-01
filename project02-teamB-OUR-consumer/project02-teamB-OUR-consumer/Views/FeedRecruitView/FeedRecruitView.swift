//
//  FeedRecruitView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 윤해수 on 2023/08/22.
//

import SwiftUI
import MapKit
import CoreLocationUI
import CoreLocation
import PhotosUI


struct FeedRecruitView: View {
    
    @Environment(\.dismiss) private var dismiss: DismissAction
    
    @EnvironmentObject var feedStoreViewModel: FeedRecruitStore
    
    let userID: String = UserDefaults.standard.string(forKey: Keys.userId.rawValue ) ?? ""
    @State var privacySetting: PrivacySetting = PrivacySetting.Public
    @State var content: String = ""
    @State var locationAddress: String = ""
    @State var selectedImages: [UIImage] = []
    @State var feedImagePath: [String] = []
    @State var selectedItem: [PhotosPickerItem] = []
    @State var isAlert: Bool = false
    @State var createdDate: Date = Date()
    @State var newFeed: FeedRecruitModel = FeedRecruitModel(creator: "", content: "", location: "", privateSetting: false, reportCount: 0, postImagePath: [])
    
    
    //MARK: - 1번 Toast 선언하기
    @State var toast: Toast? = nil
    
    var body: some View {
        
        NavigationStack {
            ScrollView{
                
                VStack(alignment: .leading){
                    //공개범위 뷰
                    FeedRecruitPrivateSettingView(privacySetting: $privacySetting)
                    
                    //위치설정 뷰
                    FeedRecruitLocationView(locationAddress: $locationAddress)
                        .padding(.horizontal)
                    
                }
                .padding()
                
                //content 글 작성뷰
                FeedRecruitTextEditorView(content: $content)
                    .padding(.horizontal, 20.0)
                
                //사진추가 View
                FeedRecruitPhotoAddView(selectedImages: $selectedImages, selectedItem: $selectedItem)
                    .padding(.horizontal, 20.0)
                
            }
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button("취소") { dismiss() }
                }
                
                ToolbarItem(placement:.navigationBarTrailing) {
                    
                    Button("등록") {
                        
                        if selectedItem.isEmpty {
                            feedImagePath.removeAll()
                            let newFeed1 = FeedRecruitModel(creator: userID, content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0,createdAt: createdDate.toString(), postImagePath: feedImagePath)
                            
                            self.newFeed = newFeed1
                            
                            
                            //print("사진 없을 경우 : \(newFeed)")
                            feedStoreViewModel.addFeed(newFeed)
                            //MARK: - 3번 원하는 구간에서 메세지 넣어주기
                            toast = Toast(style: .success, message: "등록 완료",  width: 110)
                            //MARK: - 4번 Toast 선언 후 true/false 로 닫거나 dismiss()하기
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                dismiss()
                            }
                            
                            return
                        } else {
                            Task {
                                do {
                                    feedImagePath.removeAll()
                                    feedImagePath = try await feedStoreViewModel.returnImagePath(items: selectedItem)
                                    
                                    
                                    //print("FeedImagePATH: \(feedImagePath)")
                                    let newFeed2 = FeedRecruitModel(creator: userID, content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0,createdAt: createdDate.toString(), postImagePath: feedImagePath)
                                    
                                    self.newFeed = newFeed2
                                    toast = Toast(style: .success, message: "등록 완료",  width: 110)
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        dismiss()
                                    }
                                    //print("사진 있을 경우: \(newFeed)")
                                    //feedStoreViewModel.addFeed(newFeed2)
                                    
                                } catch {
                                    toast = Toast(style: .success, message: "등록 실패",  width: 110)
                                    print("실패 \(error.localizedDescription)")
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        dismiss()
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                        
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
        //MARK: - 2. NavigationStack 타이틀과 같은 위치에 아래를 추가하기
        .toastView(toast: $toast)
        .navigationTitle("피드 등록")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}



struct FeedRecruitView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitView()
            .environmentObject(FeedRecruitStore())
    }
}
