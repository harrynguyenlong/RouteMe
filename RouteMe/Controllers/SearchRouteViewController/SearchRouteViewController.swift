//
//  ViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 05/07/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import UIKit
import PMAlertController
import CoreLocation

extension SearchRouteViewController: SearchViewControllerDelegate {
    
    func searchViewController(didChooseToLocation location: Location) {
        RouteSettingController.share.setToDestination(location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        RouteSettingController.share.setToDestinationName(name: location.label)
        endDestinationBtn.setTitle(location.label, for: .normal)
    }
    
    func searchViewController(didChooseFromLocation location: Location) {
        RouteSettingController.share.setFromDestination(location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        RouteSettingController.share.setFromDestinationName(name: location.label)
        startDestinationBtn.setTitle(location.label, for: .normal)
    }
    
    func searchViewControllerDidSelectFromLocationRecentSearch(location: Location) {
        RouteSettingController.share.setFromDestination(location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        RouteSettingController.share.setFromDestinationName(name: location.label)
        startDestinationBtn.setTitle(location.label, for: .normal)
    }
    
    func searchViewControllerDidSelectToLocationRecentSearch(location: Location) {
        RouteSettingController.share.setToDestination(location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        RouteSettingController.share.setToDestinationName(name: location.label)
        endDestinationBtn.setTitle(location.label, for: .normal)
    }
    
    func searchViewControllerDidChooseToLocation(location: CLLocationCoordinate2D) {
        RouteSettingController.share.setToDestination(location: location)
        RouteSettingController.share.setToDestinationName(name: "Your location")
        endDestinationBtn.setTitle("Your location", for: .normal)
    }
    
    func searchViewControllerDidChooseFromLocation(location: CLLocationCoordinate2D) {
        RouteSettingController.share.setFromDestination(location: location)
        RouteSettingController.share.setFromDestinationName(name: "Your location")
        startDestinationBtn.setTitle("Your location", for: .normal)
    }
}

extension SearchRouteViewController: SearchResultControllerDelegate {
    func searchResultControllerDelegateDidChooseFromLocation(didChooseFromLocation location: Location) {
        RouteSettingController.share.setFromDestination(location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        RouteSettingController.share.setFromDestinationName(name: location.label)
        startDestinationBtn.setTitle(location.label, for: .normal)
    }
    
    func searchResultControllerDelegateDidChooseToLocation(didChooseToLocation location: Location) {
        RouteSettingController.share.setToDestination(location: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        RouteSettingController.share.setToDestinationName(name: location.label)
        endDestinationBtn.setTitle(location.label, for: .normal)
    }
}


extension SearchRouteViewController: TimeOptionViewControllerDelegate {
    func timeOptionViewControllerDidSelectTimeOption(viewController: UIViewController, option: TimeOption) {
        switch option {
        case .leaveNow:
            timePickerBtn.setTitle("Now \u{2193}", for: .normal)
        case .lastLineForToday:
            timePickerBtn.setTitle("Last lines for today \u{2193}", for: .normal)
        case .setDepartureTime:
            
            handlePresentTimePickingView(pickingMode: .departure)
            
        case .setArrivalTime:
            
            handlePresentTimePickingView(pickingMode: .arrival)
        }
    }
}

class SearchRouteViewController: UIViewController {
    
    var isInHighLightMode: Bool = false {
        didSet {
            if isInHighLightMode {
                // Todo: Animate the info view
                
                animateInfoView()
                
            } else {
                // Todo: Animate the info view back to normal state
                
                restoreInfoViewToInitialState()
            }
        }
    }
    
    // MARK: Presentation
    
    lazy var slideInTransitionDelegate = SlideInPresentationManager()
    
    // MARK: Constraint
    
    var heightConstraint: NSLayoutConstraint?
    
    var buttonHeightConstraint: NSLayoutConstraint?
    
    var startContainerHeightConstraint: NSLayoutConstraint?
    
    var endContainerHeightConstraint: NSLayoutConstraint?
    
    var clockHeightConstraint: NSLayoutConstraint?
    
    var clockWidthConstraint: NSLayoutConstraint?
    
    var timePickerHeightConstraint: NSLayoutConstraint?
    
    var timePickerWidthConstraint: NSLayoutConstraint?
    
    var transportOptionHeightConstraint: NSLayoutConstraint?
    
    var transportOptionWidthConstraint: NSLayoutConstraint?
    
    // MARK: Views
    
    lazy var transportOptionBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Transport Options", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 3
        btn.addTarget(self, action: #selector(handlePickingTransportOption), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var timePickerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Now \u{2193}", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(handlePickTime), for: .touchUpInside)
        return btn
    }()
    
    lazy var clockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "alarm-clock").withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var swapBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "swap").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.isHidden = true
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(handleSwapDestination), for: .touchUpInside)
        return btn
    }()
    
    lazy var startDestinationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Choose location", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(handleSetStartDestination), for: .touchUpInside)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    lazy var endDestinationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Choose location", for: .normal)
        btn.isEnabled = false
        btn.setTitleColor(.black, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(handleSetEndDestination), for: .touchUpInside)
        return btn
    }()
    
    lazy var startLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textColor = UIColor.labelColor()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var endLabel: UILabel = {
        let label = UILabel()
        label.text = "End"
        label.textColor = UIColor.labelColor()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var endContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var startContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    lazy var findRouteBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .orange
        btn.setTitle("Find routes", for: .normal)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(handleFindRoutes), for: .touchUpInside)
        return btn
    }()
    
    lazy var mainTitle: UILabel = {
        let title = UILabel()
        title.text = "Plan a Journey"
        title.font = UIFont.boldSystemFont(ofSize: 15)
        title.textColor = .white
        return title
    }()
    
    lazy var routeRecommendationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .green
        return collectionView
    }()
    
    lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.isHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDimmingView)))
        return view
    }()
    
    lazy var editBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEditBtnClicked))
        
        return btn
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapInfoView)))
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        setupViewController()
        
        
        
        
    }
    
    private func setupNavBar() {
        
        navigationItem.titleView = mainTitle
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        
        navigationItem.rightBarButtonItem = editBtn
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    private func setupViewController() {
        
        view.backgroundColor = .white
        
        view.addSubview(routeRecommendationCollectionView)
        
        routeRecommendationCollectionView.frame = CGRect(x: 0, y: 80, width: view.bounds.width, height: view.bounds.height)
        
        view.addSubview(dimmingView)
        
        self.dimmingView.anchor(top: self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(infoView)
        
        infoView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        heightConstraint = infoView.heightAnchor.constraint(equalToConstant: 80)
        
        heightConstraint?.isActive = true
        
        self.infoView.addSubview(findRouteBtn)
        findRouteBtn.anchor(top: nil, left: self.infoView.leftAnchor, bottom: self.infoView.bottomAnchor, right: self.infoView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        buttonHeightConstraint = findRouteBtn.heightAnchor.constraint(equalToConstant: 0)
        
        buttonHeightConstraint?.isActive = true
        
        setupUpperView()
        
        setupLowerView()
    }
    
    // MARK: Handle gesture methods
    
    @objc private func handlePickingTransportOption() {
        print("handle Picking transport Option")
        
        let navVC = UINavigationController(rootViewController: TransportOptionViewController())
        
        self.present(navVC, animated: true, completion: nil)
    }
    
    @objc private func handlePickTime() {
        let vc = TimeOptionViewController()
        
        slideInTransitionDelegate.direction = .bottom
        
        slideInTransitionDelegate.sizeInParentContainer = 2 / 5
        
        vc.transitioningDelegate = slideInTransitionDelegate
        
        vc.modalPresentationStyle = .custom
        
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc private func handleFindRoutes() {
        print("Find suggested routes")
    }
    
    @objc private func handleSetEndDestination() {
        let vc = SearchViewController()
        vc.searchMode = .to
        vc.delegate = self
        if let resultVC = vc.searchController.searchResultsController as? SearchResultController {
            resultVC.delegate = self
        }
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .overFullScreen
        navVc.modalTransitionStyle = .crossDissolve
        
        self.definesPresentationContext = true
        self.present(navVc, animated: true, completion: nil)
    }
    
    @objc private func handleSetStartDestination() {
        let vc = SearchViewController()
        vc.searchMode = .from
        vc.delegate = self
        if let resultVC = vc.searchController.searchResultsController as? SearchResultController {
            resultVC.delegate = self
        }
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .overFullScreen
        navVc.modalTransitionStyle = .crossDissolve
        
        self.definesPresentationContext = true
        self.present(navVc, animated: true, completion: nil)
    }
    
    @objc private func handleEditBtnClicked() {
        self.isInHighLightMode = !isInHighLightMode
    }
    
    @objc private func handleTapDimmingView() {
        self.isInHighLightMode = !isInHighLightMode
    }
    
    @objc private func handleTapInfoView() {
        if self.isInHighLightMode {
            // Do nothing
            
        } else {
            // Animate info view
            
            self.isInHighLightMode = !isInHighLightMode
        }
    }
    
    @objc private func handleSwapDestination() {
        
        if RouteSettingController.share.swapDestination() {
            
            let startLbl = self.startDestinationBtn.titleLabel?.text
            
            self.startDestinationBtn.setTitle(self.endDestinationBtn.titleLabel?.text ?? "", for: .normal)
            self.endDestinationBtn.setTitle(startLbl ?? "", for: .normal)
            
            
        } else {
            // Show alert
            
            let alertVC = PMAlertController(title: "Error", description: "You need to choose location that you wish to go to and from in order to continue", image:#imageLiteral(resourceName: "caution"), style: .alert)
            
            alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: {
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // MARK: Animate methods
    
    private func animateInfoView() {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveLinear, animations: {
            self.buttonHeightConstraint?.constant = 40
            self.dimmingView.isHidden = false
            self.swapBtn.isHidden = false
            self.heightConstraint?.constant = 200
            self.startDestinationBtn.isEnabled = true
            self.endDestinationBtn.isEnabled = true
            self.startContainerHeightConstraint?.constant = 40
            self.endContainerHeightConstraint?.constant = 40
            self.timePickerHeightConstraint?.constant = 15
            self.timePickerWidthConstraint?.constant = 150
            self.clockHeightConstraint?.constant = 10
            self.clockWidthConstraint?.constant = 10
            self.transportOptionWidthConstraint?.constant = 150
            self.transportOptionHeightConstraint?.constant = 25
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func restoreInfoViewToInitialState() {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveLinear, animations: {
            self.buttonHeightConstraint?.constant = 0
            self.dimmingView.isHidden = true
            self.heightConstraint?.constant = 80
            self.startContainerHeightConstraint?.constant = 30
            self.endContainerHeightConstraint?.constant = 30
            self.clockHeightConstraint?.constant = 0
            self.clockWidthConstraint?.constant = 0
            self.timePickerHeightConstraint?.constant = 0
            self.timePickerWidthConstraint?.constant = 0
            self.transportOptionWidthConstraint?.constant = 0
            self.transportOptionHeightConstraint?.constant = 0
            self.swapBtn.isHidden = true
            self.startDestinationBtn.isEnabled = false
            self.endDestinationBtn.isEnabled = false
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // Setup methods
    
    private func setupLowerView() {
        
        self.infoView.addSubview(clockIcon)
        clockIcon.anchor(top: endContainerView.bottomAnchor, left: infoView.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        clockHeightConstraint = clockIcon.heightAnchor.constraint(equalToConstant: 0)

        clockWidthConstraint = clockIcon.widthAnchor.constraint(equalToConstant: 0)

        clockWidthConstraint?.isActive = true

        clockHeightConstraint?.isActive = true
        
        self.infoView.addSubview(timePickerBtn)
        
        timePickerBtn.anchor(top: endContainerView.bottomAnchor, left: clockIcon.rightAnchor, bottom: nil, right: nil, paddingTop: 13, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        timePickerHeightConstraint = timePickerBtn.heightAnchor.constraint(equalToConstant: 0)
        
        timePickerWidthConstraint = timePickerBtn.widthAnchor.constraint(equalToConstant: 0)
        
        timePickerHeightConstraint?.isActive = true
        
        timePickerWidthConstraint?.isActive = true
        
        self.infoView.addSubview(transportOptionBtn)
        
        transportOptionBtn.anchor(top: endContainerView.bottomAnchor, left: nil, bottom: nil, right: infoView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        transportOptionHeightConstraint = transportOptionBtn.heightAnchor.constraint(equalToConstant: 0)
        
        transportOptionHeightConstraint?.isActive = true
        
        transportOptionWidthConstraint = transportOptionBtn.widthAnchor.constraint(equalToConstant: 0)
        
        transportOptionWidthConstraint?.isActive = true
        
    }
    
    private func setupUpperView() {
        self.infoView.addSubview(startContainerView)
        
        startContainerView.anchor(top: infoView.topAnchor, left: infoView.leftAnchor, bottom: nil, right: infoView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        startContainerHeightConstraint = startContainerView.heightAnchor.constraint(equalToConstant: 30)
        
        startContainerHeightConstraint?.isActive = true
        
        self.infoView.addSubview(endContainerView)
        
        endContainerView.anchor(top: startContainerView.bottomAnchor, left: infoView.leftAnchor, bottom: nil, right: infoView.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        
        endContainerHeightConstraint = endContainerView.heightAnchor.constraint(equalToConstant: 30)
        
        endContainerHeightConstraint?.isActive = true
        
        startContainerView.addSubview(startLabel)
        
        startLabel.anchor(top: startContainerView.topAnchor, left: startContainerView.leftAnchor, bottom: startContainerView.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 10, paddingBottom: 3, paddingRight: 0, width: 30, height: 0)
        
        endContainerView.addSubview(endLabel)
        
        endLabel.anchor(top: endContainerView.topAnchor, left: endContainerView.leftAnchor, bottom: endContainerView.bottomAnchor, right: nil, paddingTop: 3, paddingLeft: 10, paddingBottom: 3, paddingRight: 0, width: 30, height: 0)
        
        startContainerView.addSubview(swapBtn)
        
        swapBtn.anchor(top: startContainerView.topAnchor, left: nil, bottom: startContainerView.bottomAnchor, right: startContainerView.rightAnchor, paddingTop: 3, paddingLeft: 5, paddingBottom: 3, paddingRight: 3, width: 25, height: 0)
        
        startContainerView.addSubview(startDestinationBtn)

        startDestinationBtn.anchor(top: startContainerView.topAnchor, left: startLabel.rightAnchor, bottom: startContainerView.bottomAnchor, right: swapBtn.leftAnchor, paddingTop: 3, paddingLeft: 10, paddingBottom: 3, paddingRight: 5, width: 0, height: 0)
        
        endContainerView.addSubview(endDestinationBtn)
        
        endDestinationBtn.anchor(top: endContainerView.topAnchor, left: endLabel.rightAnchor, bottom: endContainerView.bottomAnchor, right: endContainerView.rightAnchor, paddingTop: 3, paddingLeft: 10, paddingBottom: 3, paddingRight: 5, width: 0, height: 0)
    }
    
    private func handlePresentTimePickingView(pickingMode: PickingMode) {
        let vc = TimePickerViewController()
        
        slideInTransitionDelegate.direction = .bottom
        slideInTransitionDelegate.sizeInParentContainer = 1 / 2
        
        vc.transitioningDelegate = slideInTransitionDelegate
        
        vc.modalPresentationStyle = .custom
        
        vc.pickingMode = pickingMode
        
        self.present(vc, animated: true, completion: nil)
    }
}
