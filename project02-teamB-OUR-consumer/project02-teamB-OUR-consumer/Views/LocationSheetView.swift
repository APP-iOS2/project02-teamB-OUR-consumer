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
    
    var locationName: String = "광화문역 사거리"
    
    var locationCoordinate: CLLocationCoordinate2D
    
    //locationCoordinate 여기서 안받아오면 region에 바로 쓸 수 있으려나!?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5718,
        longitude: 126.9769),
        span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text("\(locationName)")
                    .fontWeight(.heavy)
                Spacer()
            }
            
            Map(coordinateRegion: $region,
                annotationItems: [Annotation(coordinate: locationCoordinate)]) { annotation in
                MapMarker(coordinate: annotation.coordinate)
            }
            .frame(height: 250)
            
            
        }
        .padding()
    }
}

struct LocationSheetView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSheetView(locationCoordinate: CLLocationCoordinate2D(latitude: 37.5718, longitude: 126.9769))
    }
}
