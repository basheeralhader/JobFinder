//
//  JobSearchPresenter.swift
//  JobFinder
//
//  Created by OSX on 4/18/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit

protocol JobSearchRepresentation: ViewDisplayable {
    
    func updateList()
}

final class JobSearchPresenter {

    // MARK: - Properties
    
    private(set) var jobsList = [Job]()
    private(set) var searchList = [String]()
    private(set) var isSearchActive = false
    private(set) var isPositionSearchActive = false

    private weak var view: JobSearchRepresentation!
    private var useCase: ProvidersUseCase!

    private var jobsProviders = JobsProviders.allCases.first
    private var position: String?
    private var location: String?

    // MARK: - Init / Deinit
    
    init(with view: JobSearchRepresentation, useCase: ProvidersUseCase) {
        
        self.view = view
        self.useCase = useCase
    }
    
    func getNumberOfRowsInSection() -> Int {
        
        if isSearchActive, !searchList.isEmpty {
            return searchList.count
        } else {
            isSearchActive = false
            return jobsList.count
        }
    }
    
    func searchPosition(by text: String) {
        isSearchActive = true
        isPositionSearchActive = true
        searchList = getAllPostions().filter({ $0.range(of: text, options: .caseInsensitive) != nil })
    }
    
    func searchlocation(by text: String) {
        isSearchActive = true
        isPositionSearchActive = false
        searchList = getAllLocations().filter({ $0.range(of: text, options: .caseInsensitive) != nil })
    }
    
    func searchClear() {
        isSearchActive = false
        searchList.removeAll()
    }
    
    // MARK: - Fetching Data

    func getAvailableJobs() {
        
        guard let jobsProviders = jobsProviders else {
            fatalError("there's no providers")
        }
        
        view.showLoading()
        
        useCase.getJobs(from: jobsProviders, position: position ?? "", location: location ?? "") { [weak self] (jobsList, error)  in
            
            guard let self = self else { return }
            self.view.hideLoading()

            if let jobsList = jobsList {
                self.jobsList = jobsList
                if jobsList.isEmpty {
                    self.view.showAlert(with: "No result")
                }
            } else if let error = error {
                self.view.showAlert(with: error.localizedDescription)
            }
            self.view.updateList()
        }
    }
    
    func updateProvider(_ providers: JobsProviders) {
        jobsProviders = providers
    }
    
    func updateFilterValues(_ position: String?, location: String?) {
        self.position = position?.replacingOccurrences(of: " ", with: "+")
        self.location = location?.replacingOccurrences(of: " ", with: "+")
    }
    
    func getAllLocations() -> [String] {
        
        if let path = Bundle.main.path(forResource: "Locations", ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
    
    func getAllPostions() -> [String] {
        
        if let path = Bundle.main.path(forResource: "Positions", ofType: ".plist"),
            let locationsList = NSArray(contentsOfFile: path) as? [String] {
            return locationsList
        }
        return []
    }
}
