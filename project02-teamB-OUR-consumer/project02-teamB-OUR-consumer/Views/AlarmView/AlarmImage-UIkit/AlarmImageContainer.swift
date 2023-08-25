//
//  AlarmImageView.swift
//  project02-teamB-OUR-consumer
//
//  Created by 박형환 on 2023/08/25.
//

import UIKit
import SnapKit

// RoundView.swift
private enum Const {
    // view
    
    static let borderWidth: Double = 1
    static let imageOuterSpacing = Self.borderWidth + 4.0 // borderWidth만큼 안쪽으로 바깥 라인이 채워지므로 borderWidth값을 더함
    static let greenDotOuterSpacing = 1
    static let greenDotViewInset = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: 3)
    static let greenDotViewSize = CGSize(width: 10, height: 10)
    
    // shapeLayer
    static let gradationWidth = 2.0
}

class AlarmView: RoundView {
    private let containerView: RoundView = {
        let roundView = RoundView()
        roundView.backgroundColor = .clear
        roundView.isUserInteractionEnabled = false
        roundView.clipsToBounds = true
        return roundView
    }()
    
    private let alarmImageView: RoundImageView = {
        let image = RoundImageView()
        image.image = UIImage(systemName: "bell.fill")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let greenDotContainerView: RoundView = {
        let roundView = RoundView()
        roundView.isUserInteractionEnabled = false
        roundView.backgroundColor = .white
        roundView.clipsToBounds = true
        
        let greenDotView: RoundView = {
            let view = RoundView()
            view.backgroundColor = .red
            return view
        }()
        
        roundView.addSubview(greenDotView)
        
        greenDotView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Const.greenDotOuterSpacing)
        }
        return roundView
    }()
    
    
    func settingColor(color: UIColor){
        alarmImageView.tintColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.containerView)
        self.addSubview(self.greenDotContainerView)
        self.containerView.addSubview(self.alarmImageView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.alarmImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()//.inset(Const.imageOuterSpacing)
        }
        
        self.greenDotContainerView.snp.makeConstraints {
            $0.right.top.equalToSuperview().inset(Const.greenDotViewInset)
            $0.size.equalTo(Const.greenDotViewSize)
        }
    }
    
}

class RoundView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2.0
    }
}

class RoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2.0
    }
}

extension UIView {
  func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


class AlarmImageContainer: UIView{
    
    // 선언
    private let testView: AlarmView = {
        let view = AlarmView(frame: .zero)
        return view
    }()
    
    
    func settingColor(color: UIColor){
        testView.settingColor(color: color)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add SubView
        self.addSubview(testView)
        
        testView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("required init fatalError")
        
    }
    
}
