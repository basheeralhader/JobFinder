//
//  JobTableViewCell.swift
//  JobFinder
//
//  Created by OSX on 4/19/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit
import AlamofireImage

class JobTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet private weak var companyImageView: UIImageView!
    @IBOutlet private weak var jobTitleLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!

    // MARK: - Init / Deinit
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        companyImageView.image = nil
    }
    
    // MARK: - configuretion
    
    func configure(with object: Job) {
        
        jobTitleLabel.text = object.jobTitle
        companyNameLabel.text = object.companyName
        locationLabel.text = object.location
        postDateLabel.text = object.postdate?.asString
        
        let defaultCompanyLogo = UIImage(named: "company-logo")
        if let image = object.companyLogo, let url = URL(string: image) {
            companyImageView.af_setImage(withURL: url, placeholderImage: defaultCompanyLogo)
        } else {
            companyImageView.image = defaultCompanyLogo
        }
    }
}
