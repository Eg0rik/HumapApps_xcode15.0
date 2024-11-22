//
//  Form.swift
//  HumanAppsTask
//
//  Created by MAC on 11/15/24.
//

import UIKit

///Represent a table structure with `sections` and `rows`.
struct Form {
    var sections: [FormSection]
}
///Represent a section protocol  with `rows`.
protocol FormSection : AnyObject {
    var headerItem: HeaderFooterItem? { get }
    var footerItem: HeaderFooterItem? { get }
    var items: [FormItem] { get set }
    var headerHeight: CGFloat { get set }
}

/// Represent a header or footer.
protocol HeaderFooterItem {
    var identifier: String { get }
    func makeHeaderFooter() -> UIView
    func configureHeaderFooter(_ headerFooter:UIView)
}

///Represent a row.
protocol FormItem {
    /// A `String` property that determines identifier for `dequeueReusableCell` method of `UITableViewController`.
    var identifier: String { get }
    
    /// Action when the user did select `UITableViewCell`.
    var touchAction: (()->())? { get }

    func makeCell() -> UITableViewCell
    func configureCell(_ cell:UITableViewCell?)
}
