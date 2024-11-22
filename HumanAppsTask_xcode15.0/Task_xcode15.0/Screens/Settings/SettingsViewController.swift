//
//  SettingsViewController.swift
//  HumanAppsTask
//
//  Created by MAC on 11/14/24.
//

import UIKit

class SettingsViewController: FormTableViewController {
    
    
    //MARK: - Private properties
    let viewModel: SettingsViewModel
    
    //MARK: - Life Cycle
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        super.init()
        
        form = Form(sections: [
            StandardSection(items: [
                SettingsRowItem(text: "Info about developer", image: UIImage(systemName: "info.bubble.fill")) { [weak self] in
                    self?.showAlert(title: "Info", message: "Egor Eremeichik")
                },
                
                SettingsRowItem(text: "Github profile", image: UIImage(systemName: "network")) { [weak self] in
                    self?.viewModel.goToGihubProfile()
                }
            ])
        ])
        
        setupTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
}

//MARK: - Private methods
private extension SettingsViewController {
    func setupView() {
        tableView.backgroundColor = .lightGray
    }
    
    func setupTabBarItem() {
        tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "gear.circle"),
            selectedImage: UIImage(systemName: "gear.circle.fill")
        )
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Settings"
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertVC, animated: true)
    }
}

#Preview {
    makeControllerForPreview()
}
