//
//  MeetingFormView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박서연 on 2023/08/23.
//

import SwiftUI

struct StudyMeetingView: View {
    
    @Binding var onlineToggle: Bool
    @Binding var offlineToggle: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("만남의 형태를 정해주세요.")
                .font(.system(.title2))
            // pointcolor: .background(Color(hex: “#FB3741”))
            // .background(Color(hex: "#090580"))
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
                            .background(mainColor)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(mainColor, lineWidth: 1))
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
//                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    } else {
                        Text("오프라인")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .foregroundColor(.white)
                            .background(mainColor)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(mainColor, lineWidth: 1))
                    }
                }
                
            }
        }
    }
}

struct StudyMeetingView_Previews: PreviewProvider {
    static var previews: some View {
        StudyMeetingView(onlineToggle: .constant(true), offlineToggle: .constant(true))
    }
}
