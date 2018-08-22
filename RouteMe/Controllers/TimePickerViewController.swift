//
//  TimePickerViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 18/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

enum PickingMode {
    case departure
    case arrival
}

class TimePickerViewController: UIViewController {
    
    var pickingMode: PickingMode? {
        didSet {
            if pickingMode == .departure {
                mainTitle.text = "Set desired departure time"
            } else if pickingMode == .arrival {
                mainTitle.text = "Set desired arrival time"
            }
        }
    }
    
    // MARK: Views
    
    lazy var pickView: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        return picker
    }()
    
    lazy var topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    lazy var closeIcon: UIButton = {
        let icon = UIButton()
        icon.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        icon.addTarget(self, action: #selector(handleCloseIconTapped), for: .touchUpInside)
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    lazy var mainTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Set desired departure time"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    lazy var doneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Done", for: .normal)
        btn.addTarget(self, action: #selector(handleDoneBtnTapped), for: .touchUpInside)
        btn.backgroundColor = UIColor.blueColor()
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.clipsToBounds = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: Setup methods
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(doneButton)
        
        doneButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 35)
        
        view.addSubview(divider)
        
        divider.anchor(top: nil, left: view.leftAnchor, bottom: doneButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0.5)
        
        self.view.addSubview(mainTitle)
        
        mainTitle.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        self.view.addSubview(closeIcon)
        
        closeIcon.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 18, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 8, height: 8)
        
        self.view.addSubview(topDivider)
        
        topDivider.anchor(top: mainTitle.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        self.view.addSubview(pickView)
        
        pickView.anchor(top: topDivider.bottomAnchor, left: view.leftAnchor, bottom: divider.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: Gesture methods
    
    @objc private func handleDoneBtnTapped() {
        print(self.pickView.date)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleCloseIconTapped() {
        
        self.dismiss(animated: true, completion: nil)
    }
}
