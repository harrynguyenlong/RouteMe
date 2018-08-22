//
//  RecentSearchHeader.swift
//  RouteMe
//
//  Created by Long Nguyen on 09/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol RecentSearchHeaderDelegate {
    func recentSearchHeaderDidClearSearch()
}

class RecentSearchHeader: UIView {
    
    var delegate: RecentSearchHeaderDelegate?
    
    lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.headerTextColor()
        lbl.text = "Recent"
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    lazy var clearBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Clear", for: .normal)
        btn.addTarget(self, action: #selector(handleClearAllSearch), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        backgroundColor = UIColor.headerBackGroundColor()
        
        self.addSubview(title)
        
        title.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 8, paddingBottom: 3, paddingRight: 0, width: 150, height: 0)
        
        self.addSubview(clearBtn)
        
        clearBtn.anchor(top: self.topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 3, paddingRight: 0, width: 70, height: 0)
    }
    
    @objc private func handleClearAllSearch() {
        delegate?.recentSearchHeaderDidClearSearch()
    }
}
