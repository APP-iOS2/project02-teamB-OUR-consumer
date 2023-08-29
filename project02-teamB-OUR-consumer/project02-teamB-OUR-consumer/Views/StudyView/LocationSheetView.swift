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
    
    var study: Study
    @State var locationCoordinate: CLLocationCoordinate2D
    //locationCoordinate 여기서 안받아오면 region에 바로 쓸 수 있으려나!?
    @State private var region = MKCoordinateRegion()
    
    @Binding var isShowingLocationSheet: Bool
    
    var body: some View {
        
        NavigationStack {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(study.locationName ?? "(위치 없음)")
                    .fontWeight(.heavy)
                Spacer()
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
            
            Map(coordinateRegion: $region,
                annotationItems: [Annotation(coordinate: locationCoordinate)]) { annotation in
                MapMarker(coordinate: annotation.coordinate)
            }
                .frame(height: 250)
                .onAppear {
                    setRegion(locationCoordinate)
                }
        }
        .padding()
        .onAppear {
            print(locationCoordinate)
            setRegion(locationCoordinate)
        }
    }
    
    
    func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        }
}

struct LocationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSheetView(study: Study(creatorId: "", title: "", description: "", studyDate: "", deadline: "", isOnline: false, currentMemberIds: [""], totalMemberCount: 0, createdAt: "23.08.28"), locationCoordinate: CLLocationCoordinate2D(latitude: 37.49733287620238, longitude: 127.02891033313006), isShowingLocationSheet: .constant(false))
    }
}
