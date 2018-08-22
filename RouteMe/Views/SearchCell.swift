//
//  SearchCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 09/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SearchCell: UITableViewCell {
    
    var recent: RecentSearchObjectRealm? {
        didSet {
            guard let location = recent else { return }
            
            switch location.locationType {
            case .address:
                icon.image = #imageLiteral(resourceName: "location")
            case .stop:
                icon.image = #imageLiteral(resourceName: "bus-stop")
            case .venue:
                icon.image = #imageLiteral(resourceName: "venue")
            case .street:
                icon.image = #imageLiteral(resourceName: "street")
            case .station:
                icon.image = #imageLiteral(resourceName: "station")
            }
            
            name.text = location.name
            
            subInfo.text = "\(location.locality), \(location.region)"
        }
    }
    
    var location: Location? {
        didSet {
            guard let location = location else { return }
            
            switch location.locationType {
            case .address:
                icon.image = #imageLiteral(resourceName: "location")
            case .stop:
                icon.image = #imageLiteral(resourceName: "bus-stop")
            case .venue:
                icon.image = #imageLiteral(resourceName: "venue")
            case .street:
                icon.image = #imageLiteral(resourceName: "street")
            case .station:
                icon.image = #imageLiteral(resourceName: "station")
            }
            
            name.text = location.label
            
            subInfo.text = "\(location.locality), \(location.region)"
        }
    }
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "location")
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        return icon
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.text = "Kilonrinne 10"
        name.font = UIFont.systemFont(ofSize: 14)
        return name
    }()
    
    lazy var subInfo: UILabel = {
        let info = UILabel()
        info.text = "Espoo, Uusimaa"
        info.textColor = .darkGray
        info.font = UIFont.systemFont(ofSize: 11)
        return info
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .white
        
        selectionStyle = .none
        
        addSubview(icon)
        
        icon.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 15, paddingLeft: 10, paddingBottom: 15, paddingRight: 0, width: 15, height: 0)
        
        addSubview(name)
        
        name.anchor(top: topAnchor, left: icon.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 20)
        
        addSubview(subInfo)
        
        subInfo.anchor(top: name.bottomAnchor, left: icon.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 0)
    }
}
