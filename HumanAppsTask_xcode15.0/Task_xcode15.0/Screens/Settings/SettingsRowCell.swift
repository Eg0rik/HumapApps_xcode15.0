//
//  SettingsRowCell.swift
//  HumanAppsTask
//
//  Created by MAC on 11/15/24.
//

import UIKit
import SnapKit

class SettingsRowCell: UITableViewCell {
    
    static let identifier = "SettingsRowCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, image: UIImage?) {
        var config = defaultContentConfiguration()
        config.text = text
        config.image = image
        
        contentConfiguration = config
    }
}

#Preview {
    makeControllerForPreview()
}
