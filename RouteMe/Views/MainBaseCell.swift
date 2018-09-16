//
//  BaseCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 12/09/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class MainBaseCell: UICollectionViewCell {
    
    lazy var travelTimeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "14:12 - 15:05"
        lbl.textAlignment = .left
        lbl.backgroundColor = .clear
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 13)
        return lbl
    }()
    
    lazy var divider: UIView = {
        let dvider = UIView()
        dvider.backgroundColor = .lightGray
        return dvider
    }()
    
    lazy var minNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.attributedText = createAttributedText(firstString: "89\n", secondString: "min")
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "3,5€"
        lbl.textAlignment = .center
        lbl.backgroundColor = .clear
        lbl.textColor = .darkGray
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(minNumberLbl)
        
        minNumberLbl.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 0)
        
        addSubview(priceLbl)
        
        priceLbl.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 40, height: 40)
        
        addSubview(divider)
        
        divider.anchor(top: nil, left: minNumberLbl.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        addSubview(travelTimeLbl)
        
        travelTimeLbl.anchor(top: nil, left: minNumberLbl.rightAnchor, bottom: bottomAnchor, right: priceLbl.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 0, height: 20)
    }
    
    func createAttributedText(firstString: String, secondString: String) -> NSAttributedString {
        
        let firstAttributedString = NSMutableAttributedString(string: firstString, attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir-Heavy", size: 20)!, NSAttributedStringKey.foregroundColor : UIColor.black])
        firstAttributedString.append(NSMutableAttributedString(string: secondString, attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir-Medium", size: 12)!, NSAttributedStringKey.foregroundColor : UIColor.black]))
        
        return firstAttributedString
    }
}
