//
//  FilterType.swift
//  HumanAppsTask
//
//  Created by MAC on 11/15/24.
//

enum FilterType : String, CaseIterable {
    case original = "Original"
    case instant = "CIPhotoEffectInstant"
    case mono = "CIPhotoEffectMono"
    case transfer =  "CIPhotoEffectTransfer"
    
    var nameForUser: String {
        switch self {
            case .original: "Orig"
            case .instant: "Instant"
            case .mono: "Mono"
            case .transfer: "Transfer"
        }
    }
}
