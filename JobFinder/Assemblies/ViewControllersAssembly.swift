//
//  ViewControllersAssembly.swift
//  JobFinder
//
//  Created by OSX on 4/18/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//


import UIKit

final class ViewControllersAssembly {
    
    // MARK: - Static properties
    
    static private(set) var jobSearch: UIStoryboard = { UIStoryboard(name: "JobSearch") }()
    // Add a new storyboard here
    
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
