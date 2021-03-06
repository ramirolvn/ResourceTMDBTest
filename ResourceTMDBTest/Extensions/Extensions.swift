import Foundation
import UIKit

extension String {
    
    var utcDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        let separetedDate = self.replacingOccurrences(of: " UTC", with: "")
        guard let utcD = formatter.date(from: separetedDate) else {
            return nil
        }
        return utcD
    }
    
    var formattedDate: String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let myDate = dateFormatter.date(from: self) else{ return nil}
        
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: myDate)
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
    
    func loading() {
        let nib = UINib(nibName: "CustomAlertLoadingView", bundle: nil)
        let customAlert = nib.instantiate(withOwner: self, options: nil).first as! CustomAlertLoadingView
        customAlert.tag = 12345
        let screen = UIScreen.main.bounds
        customAlert.center = CGPoint(x: screen.midX, y: screen.midY)
        DispatchQueue.main.async {
            self.view.endEditing(true)
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
