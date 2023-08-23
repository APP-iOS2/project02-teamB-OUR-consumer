//
//  ResumeStore.swift
//  project02-teamB-OUR-consumer
//
//  Created by 최소정 on 2023/08/22.
//

import Foundation

class ResumeStore: ObservableObject {
    @Published var resume: Resume
    var sampleDescription: String = "Lorem ipsum dolor sit amet consectetur. Magna dictum velit tempus ut. Semper aliquet morbi egestas tempus aliquam cursus viverra feugiat. Ultrices massa dictum massa nulla iaculis amet. At malesuada massa mattis sed lobortis vel."
    
    init() {
        resume = Resume(userId: UUID(),
                        introduction: sampleDescription,
                        workExperience: [WorkExperience(jobTitle: "iOS 개발자",
                                                        company: Company(companyName: "Netflix", companyImage: "CompanyImageSample"),
                                                        startDate: Date().timeIntervalSince1970,
                                                        endDate: Date().timeIntervalSince1970,
                                                        description: sampleDescription),
                                         WorkExperience(jobTitle: "디자이너",
                                                        company: Company(companyName: "Netflix", companyImage: "CompanyImageSample"),
                                                        startDate: Date().timeIntervalSince1970,
                                                        endDate: Date().timeIntervalSince1970,
                                                        description: sampleDescription),
                                         WorkExperience(jobTitle: "연구원",
                                                        company: Company(companyName: "Netflix", companyImage: "CompanyImageSample"),
                                                        startDate: Date().timeIntervalSince1970,
                                                        endDate: Date().timeIntervalSince1970,
                                                        description: sampleDescription),
                                         WorkExperience(jobTitle: "연구원",
                                                        company: Company(companyName: "Netflix", companyImage: "CompanyImageSample"),
                                                        startDate: Date().timeIntervalSince1970,
                                                        endDate: Date().timeIntervalSince1970,
                                                        description: sampleDescription),],
                        education: [Education(schoolName: "TECH!T 앱 스쿨 2기",
                                              degree: "재학중",
                                              fieldOfStudy: "iOS",
                                              startDate: Date(),
                                              endDate: Date(),
                                              description: sampleDescription),
                                    Education(schoolName: "멋사대학원",
                                              degree: "졸업",
                                              fieldOfStudy: "소프트웨어",
                                              startDate: Date(),
                                              endDate: Date(),
                                              description: sampleDescription),
                                    Education(schoolName: "멋사대학교",
                                              degree: "졸업",
                                              fieldOfStudy: "디자인",
                                              startDate: Date(),
                                              endDate: Date(),
                                              description: sampleDescription),
                                    Education(schoolName: "멋사고등학교",
                                              degree: "졸업",
                                              fieldOfStudy: "이과",
                                              startDate: Date(),
                                              endDate: Date(),
                                              description: sampleDescription),],
                        skills: [Skill(skillName: "SwiftUI",
                                       description: sampleDescription),
                                 Skill(skillName: "Team Leadership",
                                       description: sampleDescription),
                                 Skill(skillName: "Public Speaking",
                                       description: sampleDescription),
                                 Skill(skillName: "Swift",
                                       description: sampleDescription),],
                        projects: [Project(projectTitle: "Netflix (iOS)",
                                           jobTitle: "iOS Developer",
                                           startDate: Date(),
                                           endDate: Date(),
                                           description: sampleDescription),
//                                   Project(projectTitle: "Instagram",
//                                           jobTitle: "iOS Developer",
//                                           startDate: Date(),
//                                           endDate: Date(),
//                                           description: sampleDescription),
                                   Project(projectTitle: "LinkedIn (iOS)",
                                           jobTitle: "Designer",
                                           startDate: Date(),
                                           endDate: Date(),
                                           description: sampleDescription),])
    }
}
