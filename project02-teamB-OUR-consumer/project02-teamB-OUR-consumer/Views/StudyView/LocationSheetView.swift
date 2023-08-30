//
//  LocationSheetView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 여성은 on 2023/08/22.
//

import SwiftUI
import MapKit

struct Annotation: Identifiable {
    var id: UUID = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct LocationSheetView: View {
    
    var viewModel: StudyViewModel
    
    // map이 무거워서 onAppear로 coordinate가 값을 받아와도 변경이 안됨. 그래서 이 값이 true일때 Map을 보여라! 라고 해주는거임
    @State var isChangedState: Bool = false
    @State var locationCoordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.326166, longitude: 126.827480), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @Binding var isShowingLocationSheet: Bool
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(viewModel.studyDetail.locationName ?? "(위치 없음)")
                        .fontWeight(.heavy)
                    Spacer()
                }
                if isChangedState {
                    Map(coordinateRegion: $region,
                        annotationItems: [Annotation(coordinate: locationCoordinate)]) { annotation in
                        MapMarker(coordinate: annotation.coordinate)
                    }
                        .frame(height: 250)
                }
            }
            .padding()
            .onAppear {
                // region값을 바꿔놓은 후에 isChangedState값을 토글시켜서 map 보여주기!
                region.center = locationCoordinate
                isChangedState.toggle()
            }
            .navigationTitle("모임 장소 위치")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingLocationSheet = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct LocationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSheetView(viewModel: StudyViewModel(), locationCoordinate: CLLocationCoordinate2D(latitude: 37.49733287620238, longitude: 127.02891033313006), isShowingLocationSheet: .constant(false))
    }
}
