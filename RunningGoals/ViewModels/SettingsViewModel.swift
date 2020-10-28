//
//  SettingsViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 28/10/2020.
//

import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModels: [SettingsItemViewModel] = []
    let navigationTitle = "Paramètres"
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        default:
            break
//        case .mode:
//
//        case .privacy:
            
            
        }
    }
    
    private func buildItems(){
        itemViewModels = [
            .init(title: "Créer un compte", iconName: "person.circle", type: .account),
            .init(title: "Passer en thème \(isDarkMode ? "clair" : "sombre")", iconName: "lightbulb", type: .mode),
            .init(title: "Vie privée", iconName: "shield", type: .privacy)
        ]
    }
    
    func onAppear() {
        itemViewModels = [
            .init(title: "Créer un compte", iconName: "person.circle", type: .account),
            .init(title: "Passer en thème \(isDarkMode ? "clair" : "sombre")", iconName: "lightbulb", type: .mode),
            .init(title: "Vie privée", iconName: "shield", type: .privacy)
        ]
    }
}
