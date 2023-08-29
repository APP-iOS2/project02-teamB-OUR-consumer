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
    
    @StateObject var feedStoreViewModel: FeedRecruitStore = FeedRecruitStore()
    
    @State var privacySetting: PrivacySetting = PrivacySetting.Public
    @State var content: String = ""
    @State var locationAddress: String = ""
    @State var selectedImages: [UIImage] = []
    @State var postImagePath: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State var isAlert: Bool = false
    @State var createdDate: Date = Date()
    @State var newFeed: FeedRecruitModel = FeedRecruitModel(creator: "", content: "", location: "", privateSetting: false, reportCount: 0, postImagePath: "")
    
    
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
                FeedRecruitPhotoAddView(selectedItem: $selectedItem, selectedImages: $selectedImages)
                    .padding(.horizontal, 20.0)
                
            }
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button("취소") {
                        
                        dismiss()
                    }
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button("등록") {
                        isAlert = true
                        
                        guard let imageItem = selectedItem else {
                            let newFeed1 = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0, createdAt: createdDate.toString(), postImagePath: postImagePath)
                            
                            self.newFeed = newFeed1
                            print(newFeed)
                            return
                        }
                        
                        Task {
                            try await  postImagePath = feedStoreViewModel.returnImagePath(item: imageItem)
                            let newFeed2 = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0,createdAt: createdDate.toString(), postImagePath: postImagePath)
                            
                            self.newFeed = newFeed2
                            print("사진 있을경우 \(newFeed)")
                            //feedStoreViewModel.addFeed(newFeed2)
                        }
                        
                    }
                    .disabled(content.isEmpty)
                }
                
            }
            .navigationTitle("피드 등록")
            .navigationBarTitleDisplayMode(.inline)
            .alert("피드", isPresented: $isAlert) {
               
                Button("등록" ,role: .destructive) {

                    print("얼러트\(newFeed)")
                    feedStoreViewModel.addFeed(newFeed)
                    newFeed =  FeedRecruitModel(creator: "", content: "", location: "", privateSetting: false, reportCount: 0, postImagePath: "")
                    dismiss()
                }
                Button("취소" ,role: .cancel) {
                    isAlert = false
                }
            } message: {
                Text("등록하시겠습니까?")
            }
            
            
        }
    }
}

struct FeedRecruitView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitView()
    }
}
