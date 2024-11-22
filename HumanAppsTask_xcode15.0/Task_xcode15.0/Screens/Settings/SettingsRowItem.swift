//
//  SettingsRowItem.swift
//  HumanAppsTask
//
//  Created by MAC on 11/15/24.
//

import UIKit

struct SettingsRowItem: FormItem {
    
    var identifier: String = SettingsRowCell.identifier
    
    let text: String
    let image: UIImage?
    let touchAction: (()->())?
    
    init(text: String, image: UIImage?, touchAction: (()->())? = nil) {
        self.text = text
        self.image = image
        self.touchAction = touchAction
    }
    
    func makeCell() -> UITableViewCell {
        let cell = SettingsRowCell(style: .default, reuseIdentifier: identifier)
        configureCell(cell)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell?) {
        guard let settingsCell = cell as? SettingsRowCell else {
            return
        }
        
        settingsCell.configure(text: text, image: image)
    }
}
