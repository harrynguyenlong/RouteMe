//
//  TransportTypeCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 15/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        
    }
}

class TransportTypeCell: BaseCell {
    
    var transportType: TransportType? {
        didSet {
            guard let transportType = transportType else { return }
            
            vehicleIcon.image = transportType.icon
            
            textLbl.text = transportType.title
            
            if transportType.isChoosen {
                checkBoxIcon.image = #imageLiteral(resourceName: "checkbox-checked")
            } else {
                checkBoxIcon.image = #imageLiteral(resourceName: "checkbox-unchecked")
            }
        }
    }
    
    lazy var textLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Ferry"
        return lbl
    }()
    
    lazy var vehicleIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "bus")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    lazy var checkBoxIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "checkbox-unchecked")
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    override func setupCell() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.addSubview(vehicleIcon)
        
        vehicleIcon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 20, paddingBottom: 3, paddingRight: 0, width: 23, height: 23)
        
        self.addSubview(textLbl)
        
        textLbl.anchor(top: topAnchor, left: vehicleIcon.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 15, paddingBottom: 3, paddingRight: 0, width: 70, height: 0)
        
        self.addSubview(checkBoxIcon)
        
        checkBoxIcon.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 3, paddingRight: 20, width: 23, height: 23)
    }
}






