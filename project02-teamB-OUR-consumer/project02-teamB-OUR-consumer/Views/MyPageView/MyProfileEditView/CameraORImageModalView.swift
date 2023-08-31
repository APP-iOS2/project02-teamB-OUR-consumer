//
//  CameraORImageModalView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 김성훈 on 2023/08/23.
//

import SwiftUI

struct CameraORImageModalView: View {
    
    enum upload {
        case camera
        case picker
    }
    
    @Binding var showModal: Bool
    var selectAction: ((upload) -> Void)
    
    var body: some View {
        List {
            
            HStack {
                Button {
                    selectAction(.picker)
                } label: {
                    Label("라이브러리에서 선택", systemImage: "photo.on.rectangle")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                }
                Spacer()
            }
            .listRowSeparator(.hidden)
            
            HStack {
                Button {
                    selectAction(.camera)
                } label: {
                    Label("사진찍기", systemImage: "camera")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                }
                
                Spacer()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .padding(.top, 20)
    }
    
}

struct CameraORImageModalView_Previews: PreviewProvider {
    static var previews: some View {
        CameraORImageModalView(showModal: .constant(true), selectAction: { _ in })
    }
}
