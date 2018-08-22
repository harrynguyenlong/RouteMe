//
//  TransportOptionHeaderView.swift
//  RouteMe
//
//  Created by Long Nguyen on 15/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class TransportOptionHeaderView: UIView {
    
    var text: String? {
        didSet {
            guard let text = text else { return }
            
            title.text = text
        }
    }
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.headerTextColor()
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupHeader() {
        self.backgroundColor = UIColor.headerBackGroundColor()
        
        self.addSubview(title)
        
        title.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 8, paddingBottom: 3, paddingRight: 0, width: 150, height: 0)
    }
}
