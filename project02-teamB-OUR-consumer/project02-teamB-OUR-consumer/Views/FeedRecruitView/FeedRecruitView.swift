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
    @State var feedImagePath: [String] = []
    @State var selectedItem: [PhotosPickerItem] = []
    @State var isAlert: Bool = false
    @State var createdDate: Date = Date()
    @State var newFeed: FeedRecruitModel = FeedRecruitModel(creator: "", content: "", location: "", privateSetting: false, reportCount: 0, postImagePath: [])
    
    
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
                    Button("취소") {
                        
                        dismiss()
                    }
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    
                    Button("등록") {
                        
                        isAlert = true
                
                    }
                    .disabled(content.isEmpty)
                    
                }
                
            }
            
            .navigationTitle("피드 등록")
            .navigationBarTitleDisplayMode(.inline)
            .alert("피드", isPresented: $isAlert) {
                
                Button("등록" ,role: .destructive) {
                    
                  
                    if selectedItem.isEmpty {
                        feedImagePath.removeAll()
                        let newFeed1 = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0,createdAt: createdDate.toString(), postImagePath: feedImagePath)
                        
                        self.newFeed = newFeed1
                        
                        //isAlert = false
                        print("사진 없을 경우 : \(newFeed)")
                        dismiss()
                    print("\(isAlert)")
         
                        return
                    } else {
                        Task {
                            feedImagePath.removeAll()
                            try await  feedImagePath = feedStoreViewModel.returnImagePath(items: selectedItem)
                            print("FeedImagePATH: \(feedImagePath)")
                            let newFeed2 = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0,createdAt: createdDate.toString(), postImagePath: feedImagePath)
                          
                            self.newFeed = newFeed2
                            print("사진 있을 경우: \(newFeed)")
                  
                       
                         
                            dismiss()
                       
                            //feedStoreViewModel.addFeed(newFeed2)
                        }
                    }

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
