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

struct FeedRecruitView: View {
    
    @StateObject var locationManager = LocationManager.shared
    @State var toolbarToogle: Bool = false
    @State var privacySetting: PrivacySetting = PrivacySetting.Public
    @State var contentText: String = ""
    @State var placeholder: String = "Share Your Idea In OUR."
    @State var address: String = ""
    
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
                    
                    //현재위치설정 버튼
                    LocationButton(.currentLocation) {
                        locationManager.requestLocation()
                        
                    }
                    //위치설명 버튼
                    Button {
                        if let location = locationManager.userLocation {
                            convertLocationToAddress(location: location)
                        }
                    } label: {
                        address.isEmpty ? Text("위치설명 버튼") : Text("\(address)")
                    }
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    
                }
                .padding()
                
                ZStack{
                    TextEditor(text: $contentText)
                        .frame(minHeight:300, maxHeight:350)
                        .buttonBorderShape(.roundedRectangle)
                        .border(Color.secondary)
                    
                    if contentText.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.secondary)
                    }
                }
                
                //사진추가 View
                FeedRecruitPhotoAddView()

            }
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button("취소") {
                        toolbarToogle.toggle()
                    }
                }
                ToolbarItem(placement:.navigationBarTrailing) {
                    Button("등록") {
                        toolbarToogle.toggle()
                    }
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
            
            self.address = "\(placemark.country ?? "") \(placemark.locality ?? "") \(placemark.name ?? "")"
        }
    }
    
    
}

struct FeedRecruitView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitView()
    }
}
