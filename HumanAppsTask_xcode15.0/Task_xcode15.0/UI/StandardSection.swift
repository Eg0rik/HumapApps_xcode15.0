//
//  StandardSection.swift
//  HumanAppsTask
//
//  Created by MAC on 11/17/24.
//

import Foundation

class StandardSection: FormSection {
    var headerItem: (any HeaderFooterItem)?
    var footerItem: (any HeaderFooterItem)?
    var items: [any FormItem]
    var headerHeight: CGFloat
    
    init(headerItem: (any HeaderFooterItem)? = nil, footerItem: (any HeaderFooterItem)? = nil, items: [any FormItem], headerHeight: CGFloat = 0) {
        self.headerItem = headerItem
        self.footerItem = footerItem
        self.items = items
        self.headerHeight = headerHeight
    }
}
