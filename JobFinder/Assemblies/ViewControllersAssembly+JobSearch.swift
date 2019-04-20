//
//  ViewControllersAssembly+JobSearch.swift
//  JobFinder
//
//  Created by OSX on 4/18/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit

extension ViewControllersAssembly {

    static func makeJobSearchViewController() -> JobSearchViewController {
        let viewController: JobSearchViewController = jobSearch.makeViewController()
        let presenter = JobSearchPresenter(with: viewController, useCase: ProvidersUseCase())
        viewController.presenter = presenter
        return viewController
    }
    
}
