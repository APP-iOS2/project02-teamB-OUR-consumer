//
//  ToastView.swift
//  project02-teamB-OUR-consumer
//
//  Created by kaikim on 2023/09/01.
//

import SwiftUI

struct ToastView: View {
    
    var style: ToastStyle
    var message: String
    var width = CGFloat.infinity
//    var onCancelTapped: (()-> Void)
    var body: some View {
      HStack(alignment: .center, spacing: 12) {
        Image(systemName: style.iconStyle)
          .foregroundColor(style.themeColor)
        Text(message)
          .font(Font.caption)
          .foregroundColor(Color.black)
          .lineLimit(1)
        
//        Spacer(minLength: 10)
          
        
//        Button {
//          onCancelTapped()
//        } label: {
//          Image(systemName: "xmark")
//            .foregroundColor(style.themeColor)
//        }
      }
      .background(Color.white)
      .tint(Color.white)
      .foregroundColor(.white)
      .padding()
      .frame(minWidth: 0, maxWidth: width)
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
            .opacity(0.1)
          
      )
      .padding(.horizontal, 16)
    }
  }


struct ToastView_Preview: PreviewProvider {
    static var previews: some View {
        ToastView(style: .success, message: "성공", width: .infinity)
    }
}
