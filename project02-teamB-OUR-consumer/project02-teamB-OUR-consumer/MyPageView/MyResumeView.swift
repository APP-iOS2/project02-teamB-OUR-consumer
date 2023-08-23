//
//  MyResumeView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import SwiftUI

struct MyResumeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    MyIntroView()
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MyWorkView()
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MyProjectView()
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MyEduView()
                        Rectangle()
                            .fill(Color("DefaultGray"))
                    MySkillView()
                }
            }
        }
    }
}

struct MyResumeView_Previews: PreviewProvider {
    static var previews: some View {
        MyResumeView()
    }
}
