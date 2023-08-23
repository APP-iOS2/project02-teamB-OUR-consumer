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
    
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocation?
    static let shared = LocationManager()
    var addressString = ""
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }

}

extension LocationManager: CLLocationManagerDelegate {
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
    
  
}

enum PrivacySetting {
    
    case Public
    case Private
    
    // 각 case에 맞게 가격을 화면에 보여주기 위해
    var setting: Bool {
        switch self {
        case .Public:
            return false
        case .Private:
            return true
        }
    }
}
