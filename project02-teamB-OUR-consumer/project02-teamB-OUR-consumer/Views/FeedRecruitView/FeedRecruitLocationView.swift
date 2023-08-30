//
//  FeedRecruitLocationView.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/29.
//

import SwiftUI

struct FeedRecruitLocationView: View {
    @StateObject var locationManager = LocationManager.shared
    @Binding var locationAddress: String
    var body: some View {
        HStack{
            
            //현재 위치설정 버튼
            Button {
                locationManager.requestLocation()
                guard let location = locationManager.userLocation else { return }
                
                Task {
                    
                    try await  locationAddress = locationManager.convertLocationToAddress(location: location)
                }
                
            } label: {
                Image(systemName: "location")
                locationAddress.isEmpty ? Text("위치설정") : Text("\(locationAddress)")
            }
            .multilineTextAlignment(.leading)
            .lineLimit(1)
        }
    }
}

struct FeedRecruitLocationView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRecruitLocationView(locationAddress: .constant(""))
    }
}
