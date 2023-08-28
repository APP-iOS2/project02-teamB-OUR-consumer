//
//  AnyView.swift
//  OURApp
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI

extension AnyView{
    static func + (left: AnyView, right: AnyView) -> AnyView{
        return AnyView(HStack(spacing: 0){left.fixedSize(horizontal: true, vertical: true)
                              right.fixedSize(horizontal: true, vertical: true)})
    }
}




