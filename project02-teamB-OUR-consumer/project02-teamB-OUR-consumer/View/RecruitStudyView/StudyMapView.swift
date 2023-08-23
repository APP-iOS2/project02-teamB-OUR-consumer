//
//  StudyMapView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/22.
//

import SwiftUI
import MapKit

struct StudyMapView: View {
    @StateObject var locationManger: StudyLocationManager = .init()
    @State var navigationTage: String?
    @State private var selectedLocality: String?
    @State private var selectedName: String?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                VStack(alignment: .leading) {
                    Text("위치를 선택해주세요.")
                        .font(.system(.title2))
                    
                    Button {
                        if let coordinate = locationManger.userLocation?.coordinate {
                            locationManger.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                            locationManger.addDraggablePin(coordiante: coordinate)
                            locationManger.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                            
                            navigationTage = "MAPVIEW"
                        }
                        
                        
                    } label: {
                        Label {
                            Text("현재 위치 사용")
                                .font(.system(size: 18, weight: .semibold))
                        } icon: {
                            Image(systemName: "location.north.circle.fill")
                        }
                        
                        .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text(selectedLocality ?? "")
                        Text(selectedName ?? "")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("지역 검색하여 추가하기", text: $locationManger.searchText)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .strokeBorder(.gray)
                    }
                    
                    if let places = locationManger.fetchedPlaces, !places.isEmpty {
                        List {
                            ForEach(places, id: \.self) { place in
                                Button {
                                    if let coordinate = place.location?.coordinate {
                                        locationManger.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                        locationManger.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                        locationManger.addDraggablePin(coordiante: coordinate)
                                        locationManger.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                        
                                        navigationTage = "MAPVIEW"
                                    }
                                } label: {
                                    HStack(spacing: 15) {
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(place.name ?? "")
                                                .font(.title3.bold())
                                                .foregroundColor(.primary)
                                            
                                            Text(place.locality ?? "")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .frame(maxHeight: 20)
                            }
                            
                        }
                        .frame(minHeight: 100)
                        .listStyle(.plain)
                    } else {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 200)
                
                .background {
                    NavigationLink(tag: "MAPVIEW", selection: $navigationTage) {
                        MapViewSelection(
                            selectedLocality: $selectedLocality,
                            selectedName: $selectedName
                        )
                            .environmentObject(locationManger)
                    } label: {}
                        .labelsHidden()
                }
                
                Spacer()
                
            }
//            .padding()
        }
    }
}

struct StudyMapView_Previews: PreviewProvider {
    static var previews: some View {
        StudyMapView()
    }
}

struct MapViewSelection: View {
    
    @EnvironmentObject var locationManager: StudyLocationManager
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedLocality: String?
    @Binding var selectedName: String?

    var body: some View {
        ZStack {
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
                // 여기 프레임이 지도 크기
            
            if let place = locationManager.pickedPlacedMark {
                VStack(spacing: 10) {
                    Text("현재 위치")
                        .font(.title2.bold())
                    
                    
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            
                            Text(place.locality ?? "")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button {
                        print(place.locality!)
                        print(type(of: place.name)) // Optional String
                        selectedLocality = place.locality
                        selectedName = place.name
                                                
                        dismiss()
                    } label: {
                        Text("Confirm location")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical,12)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green)
                            }
                            .overlay(alignment: .trailing) {
                                Image(systemName: "arrow.trailing")
                                    .font(.title3.bold())
                            }
                            .foregroundColor(.white)
                    }

                    
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

struct MapViewHelper: UIViewRepresentable {
    
    @EnvironmentObject var locationManager: StudyLocationManager
    
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
