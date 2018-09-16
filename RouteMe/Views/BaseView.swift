//
//  WalkingView.swift
//  RouteMe
//
//  Created by Long Nguyen on 12/09/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    lazy var baseImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "trainIcon")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .clear
        return image
    }()
    
    lazy var descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(baseImage)
        
        baseImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 30)
        
        addSubview(descriptionLbl)
        
        descriptionLbl.anchor(top: baseImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
