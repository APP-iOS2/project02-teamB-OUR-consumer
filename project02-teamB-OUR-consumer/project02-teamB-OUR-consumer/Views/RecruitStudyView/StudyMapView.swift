//
//  StudyMapView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/22.
//

import SwiftUI
import MapKit

class SharedViewModel: ObservableObject {
    @Published var selectedLocality: String = ""
    @Published var selectedCoordinates: [Double]?
}

struct StudyMapView: View {
    @StateObject var locationManger: StudyLocationManager = .init() // 여기서만 씀
    @State var navigationTage: String?
//    @ObservedObject var sharedViewModel: SharedViewModel
    @EnvironmentObject var sharedViewModel: SharedViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                Text("위치 선택")
                    .font(.system(.title3, weight: .semibold))
                VStack(alignment: .leading) {
                    Button {
                        if let coordinate = locationManger.userLocation?.coordinate {
                            locationManger.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                            locationManger.addDraggablePin(coordiante: coordinate)
                            locationManger.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                            
                            navigationTage = "MAPVIEW"
                        }
                    } label: {
                        HStack(spacing: 3){
                            Image(systemName: "location.north.circle.fill")
                                .font(.system(size: 18))
                            Text("현재 위치")
                                .font(.system(size: 18))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text(sharedViewModel.selectedLocality)
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
                .frame(maxWidth: .infinity)
                .frame(minHeight: 200)
                
                .background {
                    NavigationLink(tag: "MAPVIEW", selection: $navigationTage) {
                        MapViewSelection(locationManager: locationManger)
                    } label: {}
                        .labelsHidden()
                }
                
                Spacer()
                
            }
        }
    }
}

//struct StudyMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyMapView()
//              .environmentObject( SharedViewModel() )
//    }
//}

struct MapViewSelection: View {
//    @ObservedObject var sharedViewModel: SharedViewModel
    @EnvironmentObject var sharedViewModel: SharedViewModel
    @StateObject var locationManager: StudyLocationManager
    @Environment(\.dismiss) private var dismiss

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
                        print("테스트1 \(place.location?.coordinate)")
                        print("테스트2 \(place.locality!)")
               
                        print(type(of: place.name)) // Optional String
//                        selectedLocality = place.locality
//                        selectedName = place.name
                        if let locality = place.locality, let name = place.name, let locationLatitude = place.location?.coordinate.latitude, let locationLongitude = place.location?.coordinate.longitude  {
                            sharedViewModel.selectedLocality = locality + ", " + name
                            
                        
                            if sharedViewModel.selectedCoordinates == nil {
                                sharedViewModel.selectedCoordinates = []
                            }
                            
                            sharedViewModel.selectedCoordinates?.append(locationLatitude)
                            sharedViewModel.selectedCoordinates?.append(locationLongitude)
                            
                        }
//                        sharedViewModel.selectedLocality = place.locality ?? ""
                        print("sharedViewModel.selectedLocality : \(sharedViewModel.selectedLocality)")
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
