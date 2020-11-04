//
//  TabContainerViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 27/10/2020.
//

import Combine

final class TabContainerViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .goalsList
    
    let tabItemViewModel = [
        TabItemViewModel(imageName: "book", title: "Activités", type: .log),
        .init(imageName: "list.bullet", title: "Objectifs", type: .goalsList),
        .init(imageName: "gear", title: "Paramètres", type: .settings)
    ]
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case goalsList
        case settings
    }
}
