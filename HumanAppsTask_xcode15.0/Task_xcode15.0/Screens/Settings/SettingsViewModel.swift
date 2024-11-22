//
//  SettingsViewModel.swift
//  HumanAppsTask
//
//  Created by MAC on 11/17/24.
//

import UIKit

final class SettingsViewModel {
    func goToGihubProfile() {
        guard let url = URL(string: "https://github.com/Eg0rik") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
