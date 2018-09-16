//
//  TwoTransportationTypeCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 12/09/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class TwoTransportTypeCell: MainBaseCell {
    
    var intinery: ItineryDetail? {
        didSet {
            guard let itinery = intinery else {
                return
            }
            
            minNumberLbl.attributedText = createAttributedText(firstString: "\(Int((itinery.duration ?? 0) / 60))\n", secondString: "min")
            
            let legs = itinery.legs
            
            let startTime = Long((legs[0]?.startTime ?? 0) / 1000)
            let endTime = Long((legs[legs.count - 1]?.endTime ?? 0) / 1000)
            
            let startTimeDate = Date(timeIntervalSince1970: startTime)
            
            let endTimeDate = Date(timeIntervalSince1970: endTime)
            
            
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let startTimeString = timeFormatter.string(from: startTimeDate)
            let endTimeString = timeFormatter.string(from: endTimeDate)
            
            print(startTimeString, endTimeString)
            
            travelTimeLbl.text = "\(startTimeString) - \(endTimeString)"
            
            let price = Double(Double(itinery.fares?.first??.cents ?? 0) / 100.0)
            
            priceLbl.text = "\(price)€"
            
            firstBaseView.baseImage.image = getIconWithCorrespondingMode(mode: itinery.legs[0]?.mode ?? .walk)
            firstBaseView.descriptionLbl.text = getDescriptionLabel(mode: itinery.legs[0]?.mode ?? .walk, itinery: itinery, index: 0)
            
            secondBaseView.baseImage.image = getIconWithCorrespondingMode(mode: itinery.legs[1]?.mode ?? .walk)
            secondBaseView.descriptionLbl.text = getDescriptionLabel(mode: itinery.legs[1]?.mode ?? .walk, itinery: itinery, index: 1)
            
        }
    }
    
    lazy var firstBaseView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var firstArrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = #imageLiteral(resourceName: "right-arrow")
        arrow.clipsToBounds = true
        arrow.contentMode = .scaleAspectFill
        arrow.backgroundColor = .clear
        return arrow
    }()
    
    lazy var secondBaseView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(firstBaseView)
        
        firstBaseView.anchor(top: topAnchor, left: minNumberLbl.rightAnchor, bottom: travelTimeLbl.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
        
        addSubview(firstArrow)
        
        firstArrow.anchor(top: topAnchor, left: firstBaseView.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        
        addSubview(secondBaseView)
        
        secondBaseView.anchor(top: topAnchor, left: firstArrow.rightAnchor, bottom: travelTimeLbl.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
    }
    
    private func getIconWithCorrespondingMode(mode: Mode) -> UIImage {
        switch mode {
        case .walk:
            return #imageLiteral(resourceName: "walkIcon")
        case .rail:
            return #imageLiteral(resourceName: "trainIcon")
        case .subway:
            return #imageLiteral(resourceName: "metroIcon")
        case .ferry:
            return #imageLiteral(resourceName: "ferryIcon")
        case .bus:
            return #imageLiteral(resourceName: "busIcon")
        case .tram:
            return #imageLiteral(resourceName: "tramIcon")
        default:
            return #imageLiteral(resourceName: "walkIcon")
        }
    }
    
    private func getDescriptionLabel(mode: Mode, itinery: ItineryDetail, index: Int) -> String {
        if mode == .walk {
            return "\(Int(itinery.legs[index]?.distance ?? 0))m"
        } else {
            return itinery.legs[index]?.trip?.route.shortName ?? ""
        }
    }
}
