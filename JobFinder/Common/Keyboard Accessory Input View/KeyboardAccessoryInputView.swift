//
//  KeyboardAccessoryInputView.swift
//  JobFinder
//
//  Created by OSX on 4/18/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit

final class KeyboardAccessoryInputView: UIView, NibLoadable {

    @IBOutlet weak var leftBarButton: UIButton!
    
    // MARK: Properties
    
    var onClickOnDoneButton: (()->())?
    
    // MARK: Actions

    @IBAction private func doneButtonTapped(_ sender: Any) {
        onClickOnDoneButton?()
    }
    
}
