//
//  UIImage.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/22.
//

import SwiftUI


extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(targetSize, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .high
        
        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        draw(in: newRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return nil
     }
}
