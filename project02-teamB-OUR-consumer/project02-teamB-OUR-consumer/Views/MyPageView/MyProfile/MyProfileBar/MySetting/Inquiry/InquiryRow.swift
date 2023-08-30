//
//  UserChatRow.swift
//  project02-teamB-OUR-consumer
//
//  Created by 신희권 on 2023/08/22.
//

import SwiftUI

struct InquiryRow: View {
    var name: String
    @Binding var message: Message
    var body: some View {
        VStack{
            
            if message.sender == name {
                HStack{
                    Spacer()
                    HStack(alignment: .bottom) {
                        Text(message.createdDate)
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        Text(message.text)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                       
                    }
                }
                .padding(.trailing, 5)
            } else {
                
                HStack {
                    AsyncImage(url: URL(string: "https://ifh.cc/g/Q3TQYM.png")) { image in
                        image.resizable()
                        
                    } placeholder: {
                        Image(systemName: "person")
                    }
                    .border(.gray,width: 3)
                    .clipShape(Circle())
                    .frame(width: 50,height: 50)
                    .padding(5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("\(message.sender)")
                        
                        
                        HStack(alignment: .bottom){
                            Text(message.text)
                                .padding(10)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            Text("\(message.createdDate)")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    Spacer()
                }
                
                
            }
        }
    }
}


struct ChatInquiryRow_preview: PreviewProvider {
    static var previews: some View {
        InquiryRow(name: "김멋사", message: .constant(Message.mockData[0]))
        InquiryRow(name: "김멋사", message: .constant(Message.mockData[1]))
    }
}
