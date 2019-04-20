//
//  Github.swift
//  JobFinder
//
//  Created by OSX on 4/19/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import Foundation

struct GithubProvider: Codable {
    let id, type: String?
    let url: String?
    let createdAt, company: String?
    let companyURL: String?
    let location, title, description, howToApply: String?
    let companyLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, url
        case createdAt = "created_at"
        case company
        case companyURL = "company_url"
        case location, title, description
        case howToApply = "how_to_apply"
        case companyLogo = "company_logo"
    }
    
}

