//
//  TimeOptionViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 18/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit

enum TimeOption {
    case leaveNow
    case setDepartureTime
    case setArrivalTime
    case lastLineForToday
}

protocol TimeOptionViewControllerDelegate {
    func timeOptionViewControllerDidSelectTimeOption(viewController: UIViewController, option: TimeOption)
}

extension TimeOptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = texts[indexPath.item]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            delegate?.timeOptionViewControllerDidSelectTimeOption(viewController: self, option: .leaveNow)
            self.dismiss(animated: true, completion: nil)
        case 1:
            self.dismiss(animated: true, completion: nil)
            
            delegate?.timeOptionViewControllerDidSelectTimeOption(viewController: self, option: .setDepartureTime)
            
        case 2:
            self.dismiss(animated: true, completion: nil)
            
            delegate?.timeOptionViewControllerDidSelectTimeOption(viewController: self, option: .setArrivalTime)
        case 3:
            
            delegate?.timeOptionViewControllerDidSelectTimeOption(viewController: self, option: .lastLineForToday)
            
            self.dismiss(animated: true, completion: nil)
        default:
            ()
        }
        
        
    }
}

class TimeOptionViewController: UIViewController {
    
    let texts = ["Leave Now", "Set your departure time", "Set desired arrival time", "Last lines for today"]
    
    let cellID = "cellId"
    
    var delegate: TimeOptionViewControllerDelegate?
    
    // MARK: Views
    
    lazy var tableView: UITableView = {
        let tbView = UITableView()
        tbView.sectionFooterHeight = 0
        tbView.separatorStyle = .none
        tbView.backgroundColor = .white
        tbView.bounces = false
        return tbView
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor.cancelBtnColor(), for: .normal)
        btn.addTarget(self, action: #selector(handleCancelBtnTapped), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: Setup methods
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(cancelBtn)
        
        cancelBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        self.view.addSubview(divider)
        
        divider.anchor(top: nil, left: view.leftAnchor, bottom: cancelBtn.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: divider.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: Gesture methods
    
    @objc private func handleCancelBtnTapped() {
        print("Cancel btn tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
}
