//
//  ChooseLocationViewController.swift
//  RouteMe
//
//  Created by Long Nguyen on 03/08/2018.
//  Copyright © 2018 Long Nguyen. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

protocol ChooseLocationViewControllerDelegate {
    func chooseLocationViewController(didSelectFromLocation location: Location)
    func chooseLocationViewController(didSelectToLocation location: Location)
}

extension ChooseLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
    }
}

extension ChooseLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        guard let location = userLocation.location else { return }
        
        if choosenLocation == nil {
            choosenLocation = location.coordinate
            
            centerMapOnLocation(location: CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            
            getAddressFromLatLon(pdblLatitude: String(location.coordinate.latitude), withLongitude: String(location.coordinate.longitude)) { (address) in
                self.locatingAddressLbl.isHidden = true
                
                self.streetLbl.text = address.street
                self.streetLbl.isHidden = false
                
                self.subInfoLbl.text = address.subInfo
                self.subInfoLbl.isHidden = false
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("Being drag")
        
        currentLocationIndicator.image = #imageLiteral(resourceName: "currentLocationMove")
        
        self.currentLocationIndicator.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("Done")
        
        currentLocationIndicator.image = #imageLiteral(resourceName: "currentLocation")
        
        getAddressFromLatLon(pdblLatitude: String(mapView.centerCoordinate.latitude), withLongitude: String(mapView.centerCoordinate.longitude)) { (address) in
            self.locatingAddressLbl.isHidden = true
            
            self.streetLbl.text = address.street
            self.streetLbl.isHidden = false
            
            self.subInfoLbl.text = address.subInfo
            self.subInfoLbl.isHidden = false
            
            self.choosenLocation = mapView.centerCoordinate
            
        }
    }
}

class ChooseLocationViewController: UIViewController {
    
    let regionRadius: CLLocationDistance = 1000
    
    let locationManager = CLLocationManager()
    
    var choosenLocation: CLLocationCoordinate2D?
    
    var searchMode: SearchMode?
    
    var delegate: ChooseLocationViewControllerDelegate?
    
    lazy var currentLocationIndicator: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "currentLocation")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isHidden = true
        return image
    }()
    
    lazy var gpsIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "gps"), for: .normal)
        btn.addTarget(self, action: #selector(handleShowUserLocation), for: .touchUpInside)
        btn.contentMode = .scaleAspectFill
        btn.clipsToBounds = true
        btn.backgroundColor = .clear
        return btn
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    lazy var subInfoLbl: CustomLabel = {
        let lbl = CustomLabel(frame: .zero, topInset: 0, bottomInset: 10, leftInset: 0, rightInset: 0)
        lbl.text = "Kilo, Espoo"
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.isHidden = false
        return lbl
    }()
    
    lazy var streetLbl: CustomLabel = {
        let lbl = CustomLabel(frame: .zero, topInset: 13, bottomInset: 0, leftInset: 0, rightInset: 0)
        lbl.text = "Kilonrinne 10"
        lbl.textColor = .black
        lbl.backgroundColor = .clear
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.isHidden = false
        return lbl
    }()
    
    lazy var locatingAddressLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Locating address..."
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.isHidden = true
        return lbl
    }()
    
    lazy var locationIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "location")
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        return icon
    }()
    
    lazy var chooseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Choose", for: .normal)
        btn.addTarget(self, action: #selector(handleDoneBtnTapped), for: .touchUpInside)
        btn.backgroundColor = UIColor.blueColor()
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    lazy var mainTitle: UILabel = {
        let title = UILabel()
        title.text = "Choose Location"
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textColor = .white
        return title
    }()
    
    lazy var viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    // MARK: Setup methods
    
    private func setupViews() {
        self.view.backgroundColor = .red
        
        setupContainerView()
        
        setupMap()
        
        setupNavBar()
        
        askUserToEnableLocation()
    }
    
    private func askUserToEnableLocation() {
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }

    }
    
    private func setupMap() {
        
        mapView.delegate = self
        
        self.view.addSubview(mapView)
        
        mapView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.viewContainer.topAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.mapView.addSubview(currentLocationIndicator)

        currentLocationIndicator.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        currentLocationIndicator.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
        currentLocationIndicator.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        
        
        self.mapView.addSubview(gpsIcon)
        
        gpsIcon.anchor(top: nil, left: mapView.leftAnchor, bottom: mapView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 35, height: 35)
    
    }
    
    private func setupContainerView() {
        self.view.addSubview(viewContainer)
        
        viewContainer.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 130)
        
        self.view.addSubview(divider)
        
        divider.anchor(top: viewContainer.centerYAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        self.view.addSubview(chooseButton)
        
        chooseButton.anchor(top: divider.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0)
        
        self.view.addSubview(locationIcon)
        
        locationIcon.anchor(top: self.viewContainer.topAnchor, left: self.viewContainer.leftAnchor, bottom: self.divider.topAnchor, right: nil, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 0, width: 20, height: 0)
        
        self.view.addSubview(locatingAddressLbl)
        
        locatingAddressLbl.anchor(top: viewContainer.topAnchor, left: locationIcon.rightAnchor, bottom: self.divider.topAnchor, right: self.viewContainer.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        self.view.addSubview(streetLbl)
        
        streetLbl.anchor(top: viewContainer.topAnchor, left: locationIcon.rightAnchor, bottom: nil, right: self.viewContainer.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 30)
        
        self.view.addSubview(subInfoLbl)
        
        subInfoLbl.anchor(top: streetLbl.bottomAnchor, left: locationIcon.rightAnchor, bottom: self.divider.topAnchor, right: self.viewContainer.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 0)
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.titleView = mainTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismissVC))
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: false)
    }
    
    @objc private func handleDismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Handle user gesture
    
    @objc private func handleDoneBtnTapped() {
        
        guard let searchMode = searchMode else { return }
        guard let choosenLocation = choosenLocation else { return }
        
        let location = Location(latitude: choosenLocation.latitude, longitude: choosenLocation.longitude, label: streetLbl.text ?? "Choosen Location")
        
        if searchMode == .from {
            delegate?.chooseLocationViewController(didSelectFromLocation: location)
        } else {
            delegate?.chooseLocationViewController(didSelectToLocation: location)
        }
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleShowUserLocation() {
        
        guard let userLocation = mapView.userLocation.location else { return }
        
        centerMapOnLocation(location: userLocation)
        
    }
    
    // MARK: Supporting methods
    
    private func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String, completionHandler: @escaping (Address) -> ()) {
        
        self.locatingAddressLbl.isHidden = false
        
        self.streetLbl.isHidden = true
        
        self.subInfoLbl.isHidden = true
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                guard let pm = placemarks else { return }
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    print(pm.subLocality)
                    print(pm.subThoroughfare)
                    print(pm.thoroughfare)
                    print(pm.locality)
                    print(pm.country)
                    print(pm.postalCode)
                
                    guard let thoroughfare = pm.thoroughfare, let locality = pm.locality else { return }
                    
                    
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    let subInfo: String
                    
                    if pm.subLocality == nil {
                        subInfo = String(locality)
                    } else {
                        subInfo = "\(pm.subLocality ?? ""), \(locality)"
                    }
                    
                    let address: Address = Address(street: "\(thoroughfare) \(pm.subThoroughfare ?? "")", subInfo: subInfo)
                   
                    completionHandler(address)
                    
                    
                    print(addressString)
                }
        })
        
    }
}
