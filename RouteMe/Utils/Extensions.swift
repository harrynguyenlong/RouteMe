
import Foundation
import UIKit
import RealmSwift

let realm = try! Realm()

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension UIColor {
    static func mainColor() -> UIColor {
        return UIColor.rgb(red: 52, green: 50, blue: 61)
    }
    
    static func cancelBtnColor() -> UIColor {
        return UIColor.rgb(red: 123, green: 123, blue: 125)
    }
    
    static func headerBackGroundColor() -> UIColor {
        return UIColor.rgb(red: 231, green: 233, blue: 235)
    }
    
    static func headerTextColor() -> UIColor {
        return UIColor.rgb(red: 163, green: 166, blue: 169)
    }
    
    static func blueColor() -> UIColor {
        return UIColor.rgb(red: 89, green: 149, blue: 240)
    }
    
    static func labelColor() -> UIColor {
        return UIColor.rgb(red: 147, green: 146, blue: 146)
    }
    
    static func switchTintColor() -> UIColor {
        return UIColor.rgb(red: 83, green: 84, blue: 88)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}

struct Constant {
    static let statusBarHeight = min(UIApplication.shared.statusBarFrame.size.height, UIApplication.shared.statusBarFrame.size.width)
    
    
    
    static var transportOptions: TransportOptionModel {
        
        let transportOptions = Array(realm.objects(TransportOptionModel.self))
        
        if transportOptions.count == 0 {
            let newTransportOption = TransportOptionModel()
            
            newTransportOption.isSaveLocally = true
            newTransportOption.routeType = .bestRoute
            newTransportOption.transportTypes = [.bus, .train, .metro, .tram, .ferry]
            
            try! realm.write {
                realm.add(newTransportOption)
            }
            
            return newTransportOption
        }
        
        return transportOptions.first!
    }
    
    static let SEARCH_HOSTNAME = "http://api.digitransit.fi/geocoding/v1/search"
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top,  constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}



