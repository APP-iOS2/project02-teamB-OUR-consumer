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
    @StateObject var locationManager = LocationManager.shared
    @State var toolbarToogle: Bool = false
    @State var privacySetting: PrivacySetting = PrivacySetting.Public
    @State var content: String = ""
    @State var placeholder: String = "Share Your Idea In OUR."
    @State var locationAddress: String = ""
    @State var selectedImages: [UIImage] = []
    
    
    @State var feedImagePath: String = ""
    @State var selectedItem: PhotosPickerItem? = nil
    //    var toString: String {
    //
    //        UIImage.toString(selectedImages)
    //    }
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Picker("PrivacySetting", selection: $privacySetting) {
                            Text("Public").tag(PrivacySetting.Public)
                            Text("Private").tag(PrivacySetting.Private)
                        }
                        .pickerStyle(.menu)
                        Spacer()
                    }
                    HStack{
                        
                        
                        //현재 위치설정 버튼
                        Button {
                            locationManager.requestLocation()
                            if let location = locationManager.userLocation {
                                convertLocationToAddress(location: location)
                            }
                        } label: {
                            Image(systemName: "location")
                            locationAddress.isEmpty ? Text("위치설정") : Text("\(locationAddress)")
                        }
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    }.padding(.horizontal)
                    
                }
                .padding()
                
                ZStack{
                    TextEditor(text: $content)
                        .frame(minHeight:350, maxHeight:350)
                        .buttonBorderShape(.roundedRectangle)
                        .border(Color.secondary)
                    
                    if content.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.secondary)
                    }
                }
                
                //사진추가 View
                
                FeedRecruitPhotoAddView(selectedItem: $selectedItem, selectedImages: $selectedImages)
                
            }
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button("취소") {
                        toolbarToogle.toggle()
                        dismiss()
                    }
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button("등록") {
                        
                        guard let test = selectedItem else {
                            let newFeed = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0, feedImagePath: feedImagePath)
                            print("첫번째\(newFeed.content)")
                            feedStoreViewModel.addFeed(newFeed)
                            
                        
                            return
                        }
                        
                        feedStoreViewModel.returnImagePath(item: test) { urlString in
                            guard let test = urlString else {return}
                            
                            feedImagePath = test
                            
                            let newFeed2 = FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0, feedImagePath: feedImagePath)
                            
                            feedStoreViewModel.addFeed(newFeed2)
                            
                          
                            print(newFeed2.content)
                            
                        }

//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            feedStoreViewModel.addFeed(FeedRecruitModel(creator: "", content: content, location: locationAddress, privateSetting: privacySetting.setting, reportCount: 0, feedImagePath: feedImagePath))
//
//                        }

                        //content = ""
                        
                        toolbarToogle.toggle()
                    }
                    .disabled(content.isEmpty)
                }
                
            }
            
        }
    }
    //위도,경도를 주소로 변환하는 함수
    func convertLocationToAddress(location: CLLocation) {
        //"en_US_POSIX"
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "en_US_POSIX")
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks,error) in
            if error != nil {
                return
            }
            guard let placemark = placemarks?.first else {return}
            
            self.locationAddress = "\(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")"
        }
    }
    
    
}

struct FeedRecruitView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitView()
    }
}
