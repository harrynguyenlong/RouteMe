//
//  RouteTypeCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 15/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class RouteTypeCell: UITableViewCell {
    
    var routeType: RouteTypeModel? {
        didSet {
            guard let routeType = routeType else { return }
            textLbl.text = routeType.text
            
            if routeType.isChoosen {
                checkIcon.image = #imageLiteral(resourceName: "checked")
            } else {
                checkIcon.image = nil
            }
        }
    }
    
    lazy var checkIcon: UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    lazy var textLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.backgroundColor = .white
        
        self.selectionStyle = .none
        
        self.addSubview(checkIcon)
        
        checkIcon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 10, paddingBottom: 8, paddingRight: 0, width: 18, height: 18)
        
        self.addSubview(textLbl)
        
        textLbl.anchor(top: topAnchor, left: checkIcon.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 20, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
}
