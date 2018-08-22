//
//  SearchViewCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 02/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class SearchViewCell: UITableViewCell {
    
    var searchViewCellModel: SearchViewCellModel? {
        didSet {
            guard let model = searchViewCellModel else { return }
            
            icon.image = model.image
            lbl.text = model.text
        }
    }
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "navigation (1)")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var lbl: UILabel = {
        let lb = UILabel()
        lb.text = "Your location"
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textColor = UIColor.blueColor()
        return lb
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
        self.selectionStyle = .gray
        
        self.addSubview(icon)
        
        icon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 10, paddingBottom: 3, paddingRight: 0, width: 20, height: 20)
        
        self.addSubview(lbl)
        
        lbl.anchor(top: topAnchor, left: icon.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 0)
    }
}
