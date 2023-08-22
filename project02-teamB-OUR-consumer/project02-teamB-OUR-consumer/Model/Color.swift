//
//  File.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//



import SwiftUI


enum AColor{
    
    case main
    case `defalut`
    
    var color: Color {
        switch self {
        case .main:
            return Color(red: 9/255, green: 5/255, blue: 128/255)
        case .defalut:
            return Color(red: 215/255, green: 215/255, blue: 215/255)
        }
    }
}
