//
//  Extension.swift
//
//  Created by Sabarish on 07/08/19.
//  Copyright © 2019 PZY Mac Mini 7. All rights reserved.
//
import UIKit
import Foundation
private var bottomConstraint : NSLayoutConstraint?
private var imageCompletion : ((UIImage?)->())?
private var constraintValue : CGFloat = 0
extension UIViewController {
    
    //Create Alert Box
    func createAlertBox(title: String, message: String, buttonName: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonName, style: .cancel, handler: nil)
        action.setValue(UIColor(hexString: "531B93"), forKey: "titleTextColor")
        alert.setTitlet(font: UIFont(name: "SFUIDisplay-Bold", size: 15), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        alert.setMessage(font: UIFont(name: "SFUIDisplay-Medium", size: 12), color: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    //Resign Keyboard Active status
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    func isNetworkReachable() -> NSError? {
        if Reachability.isConnectedToNetwork() {
            return nil
        } else {            
            let dict = NSDictionary(objects: ["Please check your internet connection"], forKeys: [NSLocalizedDescriptionKey as NSCopying])
            self.createAlertBox(title: "", message: "Please check your internet connection", buttonName: "OK")
            return NSError(domain: "", code: 600, userInfo: dict as? [String : Any])
        }
    }
    
    func addKeyBoardObserver(with constraint : NSLayoutConstraint){
        
        bottomConstraint = constraint
        
        constraintValue = constraint.constant
    }
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())

        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)

        return randomColor
    }
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func statusBarBGColor() {
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
            statusbarView.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.5333333333, blue: 0.9568627451, alpha: 1)
            view.addSubview(statusbarView)
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.5333333333, blue: 0.9568627451, alpha: 1)
        }
    }
    
    
    
    func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
         var buffer = [T]()
         var added = Set<T>()
         for elem in source {
             if !added.contains(elem) {
                 buffer.append(elem)
                 added.insert(elem)
             }
         }
         return buffer
     }
    
}


extension String{
    func isStringWithoutSpace() -> Bool{
        return !self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    //remove html tags
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count >= 10
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func numbersFromString() -> String{        
        let result = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        return result
    }
    
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
extension CGFloat {
    func toRadian() -> CGFloat {
        return self * CGFloat(M_PI) / 180.0
    }
}

extension UIImage {

    class func convertGradientToImage(colors: [UIColor], frame: CGRect) -> UIImage {

        // start with a CAGradientLayer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame

        // add colors as CGCologRef to a new array and calculate the distances
        var colorsRef : [CGColor] = []
        var locations : [NSNumber] = []

        for i in 0 ... colors.count-1 {
            colorsRef.append(colors[i].cgColor as CGColor)
            locations.append(NSNumber(value: Float(i)/Float(colors.count)))
        }

        gradientLayer.colors = colorsRef
        gradientLayer.locations = locations

        // now build a UIImage from the gradient
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // return the gradient image
        return gradientImage ?? UIImage()
    }
    
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

extension UITableViewCell{
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())

        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)

        return randomColor
    }
}

extension UICollectionViewCell{
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())

        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)

        return randomColor
    }
}
extension UIView{
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
