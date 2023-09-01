//
//  FeedRecruitViewModel.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/08/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            print("DEBUG: Not Determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways:
            print("DEBUG: Auth always")
        case .authorizedWhenInUse:
            print("DEBUG: AUTH when in use")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return}
        self.userLocation = location
        
    }
    
    func convertLocationToAddress(location: CLLocation) async throws -> String {
        
        var test:String = ""
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "en_US_POSIX")
        
        let data = try await geocoder.reverseGeocodeLocation(location, preferredLocale: locale)
        
        test = "\(data.first?.country ?? ""), \(data.first?.locality ?? ""), \(data.first?.name ?? "")"
        print(test)
        return test
    }
    
}


