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
            Text("날짜 및 인원 선택")
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 5)
            HStack(spacing: 15) {
                
                VStack(alignment: .center) {
                    Button {
                        isShowingDateSheet.toggle()
                    } label: {
                        VStack(alignment: .center, spacing: 15) {
                            VStack(alignment: .center) {
                                Text("등록 마감일")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                Text("\(dateStore.immobilizeEndTime(endDate))")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            
                            
                            VStack(alignment: .center) {
                                Text("스터디 시작일")
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                                Text("\(dateStore.formattedDate(startDate))")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .semibold))
                            }

                        }
                    }
                    .sheet(isPresented: $isShowingDateSheet) {
                        DatePickerSheet(dateStore: DateStore(), isShowingDateSheet: $isShowingDateSheet, startDate: $startDate, endDate: $endDate)
                            .presentationDetents([.fraction(0.45)])
                    }
                }
                .font(.system(size: 15))
                .frame(minWidth: 200)
                .frame(maxHeight: 150)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                Button {
                    isShowingPersonSheet.toggle()
                } label: {
                    VStack(alignment: .center) {
                        Text("인원")
                            .font(.system(size: 18))
                        Text("\(number)명")
                            .font(.system(size: 15, weight: .semibold))
                    }
                    .foregroundColor(.black)
                }
                .sheet(isPresented: $isShowingPersonSheet) {
                    PersonnelSheet(isShowingPersonSheet: $isShowingPersonSheet, number: $number)
                        .presentationDetents([.fraction(0.45)])
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 180)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
        }

    }
}


struct ButtonMainView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMainView(startDate: .constant(Date()), endDate: .constant(Date()), number: .constant(1))
    }
}
