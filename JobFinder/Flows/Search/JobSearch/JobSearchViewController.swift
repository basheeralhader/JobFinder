//
//  ViewController.swift
//  JobFinder
//
//  Created by OSX on 4/18/19.
//  Copyright © 2019 iBasheer. All rights reserved.
//

import UIKit
import SafariServices

final class JobSearchViewController: UIViewController, StoryboardInitiable {

    // MARK: - Outlets

    @IBOutlet private weak var providerTextField: UITextField!
    @IBOutlet private weak var positionTextField: UITextField!
    @IBOutlet private weak var locationTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Parameters

    var presenter: JobSearchPresenter!
    private lazy var pickerView = UIPickerView()
    private var selectedJobsProvider = JobsProviders.allCases.first
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(JobTableViewCell.self)
        configurePickerView()
        
        presenter.getAvailableJobs()
    }
    
    // MARK: Private

    private func configurePickerView() {

        providerTextField.text = JobsProviders.allCases.first?.rawValue
        providerTextField.inputView = pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let keyboardAccessoryInputView: KeyboardAccessoryInputView = KeyboardAccessoryInputView.load()
        keyboardAccessoryInputView.onClickOnDoneButton = { [weak self] in
            guard let self = self, let selectedJobsProvider = self.selectedJobsProvider else { return }
            self.providerTextField.resignFirstResponder()

            self.presenter.updateProvider(selectedJobsProvider)
            self.presenter.getAvailableJobs()
        }
        
        providerTextField.inputAccessoryView = keyboardAccessoryInputView
    }
    
    // MARK: Actions

    @IBAction private func filterButtonTapped(_ sender: Any) {
        
        presenter.searchClear()
        tableView.reloadData()
        
        presenter.updateFilterValues(positionTextField.text, location: locationTextField.text)
        presenter.getAvailableJobs()
    }
    
    @IBAction private func textFieldDidChanged(_ sender: UITextField) {
        
        if sender == positionTextField {
            presenter.searchPosition(by: sender.text ?? "")
        } else {
            presenter.searchlocation(by: sender.text ?? "")
        }
        tableView.reloadData()
    }
}

extension JobSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if presenter.isSearchActive {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = presenter.searchList[indexPath.row]
            return cell
        } else {
            let cell: JobTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: presenter.jobsList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if presenter.isSearchActive {

            if presenter.isPositionSearchActive {
                positionTextField.text = presenter.searchList[indexPath.row]
            } else {
                locationTextField.text = presenter.searchList[indexPath.row]
            }
            
            presenter.searchClear()
            tableView.reloadData()
            
        } else if let jobLink = presenter.jobsList[indexPath.row].jobLink,
            let url = URL(string: jobLink) {
            
            let safariController = SFSafariViewController(url: url)
            safariController.modalPresentationStyle = .overCurrentContext
            present(safariController, animated: true)
        }
    }
}

// MARK: - JobSearch Representation

extension JobSearchViewController: JobSearchRepresentation {
    
    func updateList() {
        tableView.reloadData()
    }
}

extension JobSearchViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return JobsProviders.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return JobsProviders.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        providerTextField.text = JobsProviders.allCases[row].rawValue
        selectedJobsProvider = JobsProviders.allCases[row]
    }
}

