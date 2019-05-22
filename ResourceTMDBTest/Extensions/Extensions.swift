//
//  Extensions.swift
//  Gestor Escolar 2019
//
//  Created by Ramiro Lima Vale Neto on 07/05/19.
//  Copyright © 2019 Ramiro Lima Vale Neto. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var encodedBase64: String? {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    var decodedBase64: String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension UIView{
    //Customiza a view com shadow color, opacity e uma color pro radious
    func shadowBackGround(_ shadowColor: UIColor, _ shadowOpacity: Float, _ shadowRadious: CGFloat) -> UIView{
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = shadowRadious
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        return self
    }
}

extension UIViewController {
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loading(_ title: String?) {
        let nib = UINib(nibName: "CustomAlertLoadingView", bundle: nil)
        let customAlert = nib.instantiate(withOwner: self, options: nil).first as! CustomAlertLoadingView
        customAlert.tag = 12345
        //        customAlert.titleAlertLabel.text = title
        let screen = UIScreen.main.bounds
        customAlert.center = CGPoint(x: screen.midX, y: screen.midY)
        DispatchQueue.main.async {
            self.view.addSubview(customAlert)
        }
        
    }
    
    func dismissLoading() {
        if let view = self.view.viewWithTag(12345) {
            DispatchQueue.main.async {
                view.removeFromSuperview()
            }
            
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    var appDelegate: UIApplicationDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}

extension UIImage{
    func imageWithColor(_ color: UIColor) -> UIImage {
        var newImage = self
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        if let context = UIGraphicsGetCurrentContext(){
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(.normal)
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
            if let cgImage = self.cgImage{
                context.clip(to: rect, mask: cgImage)
                context.fill(rect)
                if let nImage = UIGraphicsGetImageFromCurrentImageContext(){
                    UIGraphicsEndImageContext()
                    newImage = nImage
                    return newImage
                }else{
                    return self
                }
            }else{
                return self
            }
        }else{
            return self
        }
    }
}
