//
//  StoryboardInitiable.swift
//  iTunesApps-MVVM
//
//  Created by Basheer Alhader on 2/9/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInitiable {
    
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

