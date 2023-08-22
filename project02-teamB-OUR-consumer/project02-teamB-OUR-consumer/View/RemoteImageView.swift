//
//  SwiftUIView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박찬호 on 2023/08/22.
//

import SwiftUI

struct RemoteImage: View {
    let url: String
    @State private var imageData: Data? = nil

    var body: some View {
        Group {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .interpolation(.high) // 고해상도 보간
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let imageUrl = URL(string: url) else {
            print("Invalid URL: \(url)")
            return
        }

        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            } else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
