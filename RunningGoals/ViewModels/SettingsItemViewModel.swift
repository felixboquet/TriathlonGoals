//
//  SettingsItemViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 28/10/2020.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let iconName: String
        let type: SettingsItemType
    }
    
    enum SettingsItemType {
        case account
        case mode
        case privacy
        case logout
    }
}
