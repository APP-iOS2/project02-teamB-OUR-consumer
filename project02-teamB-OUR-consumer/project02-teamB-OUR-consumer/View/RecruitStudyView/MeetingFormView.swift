//
//  MeetingFormView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//

import SwiftUI

struct MeetingFormView: View {
    
    @Binding var onlineToggle: Bool
    @Binding var offlineToggle: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("만남의 형태를 정해주세요.")
                .font(.system(.title2))
            HStack {
                Button {
                    print("Online")
                    onlineToggle.toggle()
                } label: {
                    if !onlineToggle {
                        Text("온라인")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    } else {
                        Text("온라인")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    }
                }
                
                Button {
                    print("Offline")
                    offlineToggle.toggle()
                } label: {
                    if !offlineToggle {
                        Text("오프라인")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .foregroundColor(.gray)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    } else {
                        Text("오프라인")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                    }
                }
                
            }
        }
    }
}

struct MeetingFormView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFormView(onlineToggle: .constant(true), offlineToggle: .constant(true))
    }
}
