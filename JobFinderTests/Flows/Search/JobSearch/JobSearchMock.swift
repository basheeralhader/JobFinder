//
//  JobSearchMock.swift
//  JobFinderTests
//
//  Created by OSX on 4/20/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import Foundation
@testable import JobFinder

class JobSearchMock {
    var updateListCalled = false
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var displayAlertCalled = false
}

extension JobSearchMock: JobSearchRepresentation {
    
    func updateList() {
        updateListCalled = true
    }
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func showAlert(with message: String) {
        displayAlertCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
}
