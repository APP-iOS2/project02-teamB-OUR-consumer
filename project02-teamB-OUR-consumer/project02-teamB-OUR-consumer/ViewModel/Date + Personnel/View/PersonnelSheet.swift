//
//  PersonnelSheet.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct PersonnelSheet: View {
    @Binding var isShowingPersonSheet: Bool
    @Binding var number: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("인원 선택")
                Spacer()
                Button {
                    isShowingPersonSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
            }
            Divider()
            Picker("Your age", selection: $number) {
                ForEach(1...20, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.wheel)
            Divider()
            
            Button {
                isShowingPersonSheet = false
            } label: {
                Text("선택하기")
                    .foregroundColor(Color.black)
            }
        }
        .padding()
        .font(.title2)
    }
}

struct PersonnelSheet_Previews: PreviewProvider {
    static var previews: some View {
        PersonnelSheet(isShowingPersonSheet: .constant(true), number: .constant(0))
    }
}
