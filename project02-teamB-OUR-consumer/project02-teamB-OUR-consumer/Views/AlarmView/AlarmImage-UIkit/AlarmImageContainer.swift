//
//  AlarmImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/25.
//

import UIKit
import SwiftUI
import SnapKit


class AlarmImageContainer: UIView{
    
    // 선언
    private let testView: AlarmImageView = {
        let view = AlarmImageView(frame: .zero)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(Color.gray)
        label.text = "알림"
        return label
    }()
    
    
    func settingColor(color: UIColor){
        testView.settingColor(color: color)
        titleLabel.textColor = color
    }
    func settingColor(color: Color){
        titleLabel.textColor = UIColor(color)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add SubView
        self.addSubview(testView)
        self.addSubview(titleLabel)
        
        testView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(testView.snp.bottom).offset(1)
            make.centerX.equalTo(testView.snp.centerX)
            make.bottom.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("required init fatalError")
        
    }
}

//extension UIView {
//  func asImage() -> UIImage {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
//    }
//}
