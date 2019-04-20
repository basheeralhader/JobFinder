//
//  ViewControllersAssembly.swift
//  iTunesApps-MVVM
//
//  Created by Basheer Alhader on 2/9/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit

final class ViewControllersAssembly {
    
    // MARK: - Static properties
    
    static private(set) var topApps: UIStoryboard = { UIStoryboard(name: "TopApps") }()
}

extension UIStoryboard {
    
    // MARK: - Init / Deinit
    
    convenience init(name: String) {
        self.init(name: name, bundle: .main)
    }
    
    // MARK: - Actions
    
    func makeViewController<T: StoryboardInitiable>() -> T {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
    }
}
