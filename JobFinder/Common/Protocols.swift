//
//  Protocols.swift
//  JobFinder
//
//  Created by OSX on 4/19/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

protocol ViewDisplayable: class {
    func showLoading()
    func hideLoading()
    func showAlert(with message: String)
}

extension ViewDisplayable where Self: UIViewController {
    
    func showLoading() {
        
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

protocol NibLoadable: class {
    static var nib: UINib { get }
    static var nibView: UIView { get }
}

extension NibLoadable {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    static var nibView: UIView {
        
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
    
    static func load<T: UIView>() -> T {
        
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? T else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
    
    func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError("Can't instantiate a \(self)")
        }
        
        return view
    }
}
