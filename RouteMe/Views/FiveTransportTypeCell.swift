//
//  FourTransportTypeCell.swift
//  RouteMe
//
//  Created by Long Nguyen on 12/09/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

class FiveTransportTypeCell: MainBaseCell {
    
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
            
            thirdBaseView.baseImage.image = getIconWithCorrespondingMode(mode: itinery.legs[2]?.mode ?? .walk)
            thirdBaseView.descriptionLbl.text = getDescriptionLabel(mode: itinery.legs[2]?.mode ?? .walk, itinery: itinery, index: 2)
            
            fourthBaseView.baseImage.image = getIconWithCorrespondingMode(mode: itinery.legs[3]?.mode ?? .walk)
            fourthBaseView.descriptionLbl.text = getDescriptionLabel(mode: itinery.legs[3]?.mode ?? .walk, itinery: itinery, index: 3)
            
            fifthBaseView.baseImage.image = getIconWithCorrespondingMode(mode: itinery.legs[4]?.mode ?? .walk)
            fifthBaseView.descriptionLbl.text = getDescriptionLabel(mode: itinery.legs[4]?.mode ?? .walk, itinery: itinery, index: 4)
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
    
    lazy var secondArrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = #imageLiteral(resourceName: "right-arrow")
        arrow.clipsToBounds = true
        arrow.contentMode = .scaleAspectFill
        arrow.backgroundColor = .clear
        return arrow
    }()
    
    lazy var thirdBaseView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var thirdArrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = #imageLiteral(resourceName: "right-arrow")
        arrow.clipsToBounds = true
        arrow.contentMode = .scaleAspectFill
        arrow.backgroundColor = .clear
        return arrow
    }()
    
    lazy var fourthBaseView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var fourthArrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = #imageLiteral(resourceName: "right-arrow")
        arrow.clipsToBounds = true
        arrow.contentMode = .scaleAspectFill
        arrow.backgroundColor = .clear
        return arrow
    }()
    
    lazy var fifthBaseView: BaseView = {
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
        
        addSubview(secondArrow)
        
        secondArrow.anchor(top: topAnchor, left: secondBaseView.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        
        addSubview(thirdBaseView)
        
        thirdBaseView.anchor(top: topAnchor, left: secondArrow.rightAnchor, bottom: travelTimeLbl.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
        
        addSubview(thirdArrow)
        
        thirdArrow.anchor(top: topAnchor, left: thirdBaseView.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        
        addSubview(fourthBaseView)
        
        fourthBaseView.anchor(top: topAnchor, left: thirdArrow.rightAnchor, bottom: travelTimeLbl.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
        
        addSubview(fourthArrow)
        
        fourthArrow.anchor(top: topAnchor, left: fourthBaseView.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        
        addSubview(fifthBaseView)
        
        fifthBaseView.anchor(top: topAnchor, left: fourthArrow.rightAnchor, bottom: travelTimeLbl.topAnchor, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 0)
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
