//
//  SearchGOVProvider.swift
//  JobFinder
//
//  Created by OSX on 4/19/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import Foundation

struct SearchGOVProvider: Codable {
    let id, positionTitle, organizationName, rateIntervalCode: String?
    let minimum, maximum: Int?
    let startDate, endDate: String?
    let locations: [String]?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case positionTitle = "position_title"
        case organizationName = "organization_name"
        case rateIntervalCode = "rate_interval_code"
        case minimum, maximum
        case startDate = "start_date"
        case endDate = "end_date"
        case locations, url
    }
}
