//
//  StoryboardInitiable.swift
//  JobFinder
//
//  Created by OSX on 4/18/19.
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
