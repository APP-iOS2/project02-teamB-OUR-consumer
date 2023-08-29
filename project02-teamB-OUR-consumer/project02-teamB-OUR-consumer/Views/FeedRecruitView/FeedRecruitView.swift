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
    @State var feedImagePath: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    @State var isAlert: Bool = false
    
    
    
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
                            let newFeed = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0, feedImagePath: feedImagePath)
                            
                            feedStoreViewModel.addFeed(newFeed)
//                            dismiss()
                            return
                        }
                        
                        Task {
                            try await  feedImagePath = feedStoreViewModel.returnImagePath(item: imageItem)
                            let newFeed2 = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0, feedImagePath: feedImagePath)
                            
                            //feedStoreViewModel.addFeed(newFeed2)
                        }
                        
//                        dismiss()
                    }
                    .disabled(content.isEmpty)
                }
                
            }
            .navigationTitle("피드 등록")
            .navigationBarTitleDisplayMode(.inline)
       
        }
    }
}

struct FeedRecruitView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitView()
    }
}
