//
//  ContentView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 전민돌 on 8/22/23.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
             RecruitFeedView()
            }
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView()
        }
    }
}


