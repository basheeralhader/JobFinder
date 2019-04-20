//
//  ViewControllersAssembly+TopApps.swift
//  iTunesApps-MVVM
//
//  Created by Basheer Alhader on 2/9/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit

extension ViewControllersAssembly {

    static func makeTopAppViewController() -> TopAppsTableViewController {
        let viewController: TopAppsTableViewController = topApps.makeViewController()
        let viewModel = TopAppsViewModel(with: viewController)
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func makeDetailsTopAppTableViewController(for topApp: TopApp) -> DetailsTopAppViewController {
        let viewController: DetailsTopAppViewController = topApps.makeViewController()
        let viewModel = DetailsTopAppViewModel(with: topApp)
        viewController.viewModel = viewModel
        return viewController
    }
    
}
