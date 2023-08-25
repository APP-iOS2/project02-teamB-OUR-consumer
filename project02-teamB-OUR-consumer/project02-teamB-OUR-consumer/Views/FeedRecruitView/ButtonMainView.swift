//
//  ButtonMainView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import SwiftUI

struct ButtonMainView: View {
    @ObservedObject var dateStore: DateStore = DateStore()
    
    @State var isShowingDateSheet: Bool = false
    @State var isShowingPersonSheet: Bool = false
    
    @Binding var startDate: Date
    @Binding var endDate: Date
//    @Binding var startTime: Date
    @Binding var number: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    isShowingDateSheet.toggle()
                } label: {
                    VStack {
                        Text("기간 설정")
                            .padding().frame(width: 100)
                            .foregroundColor(Color.white)
                            .background(Color(hex: "#090580"))
                            .cornerRadius(8)
                    }
                }
                
                .sheet(isPresented: $isShowingDateSheet) {
                    DatePickerSheet(dateStore: DateStore(), isShowingDateSheet: $isShowingDateSheet, startDate: $startDate, endDate: $endDate)
                        .presentationDetents([.fraction(0.45)])
                    
                }
                VStack {
                    Text("시작: \(dateStore.formattedDate(startDate))")
                    Text("마감: \(dateStore.immobilizeEndTime(endDate))")
                }
                
                
            }
            
            HStack {
                Button {
                    isShowingPersonSheet.toggle()
                } label: {
                    Text("인원 설정")
                        .padding().frame(width: 100)
                        .foregroundColor(Color.white)
                        .background(Color(hex: "#090580"))
                        .cornerRadius(8)
                    
                    
                }
                
                .sheet(isPresented: $isShowingPersonSheet) {
                    PersonnelSheet(isShowingPersonSheet: $isShowingPersonSheet, number: $number)
                        .presentationDetents([.fraction(0.45)])
                }
                
                Text("인원:  \(number) 명")
            }
        }
    }
}


//struct ButtonMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonMainView(startDate: .constant(Date()), endDate: .constant(Date()), startTime: .constant(Date()), number: 0)
//    }
//}
