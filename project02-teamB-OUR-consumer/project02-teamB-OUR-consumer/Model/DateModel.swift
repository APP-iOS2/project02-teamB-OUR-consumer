//
//  Date.swift
//  project02-teamB-OUR-consumer
//
//  Created by 송성욱 on 2023/08/23.
//

import Foundation
import SwiftUI
import Foundation

struct DateModel: Identifiable {
    var id: String = UUID().uuidString
    var startDate: Date
    var endDate: Date
}
