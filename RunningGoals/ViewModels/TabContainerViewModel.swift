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
        TabItemViewModel(imageName: "book", title: "Activity Log", type: .log),
        .init(imageName: "list.bullet", title: "Goals", type: .goalsList),
        .init(imageName: "gear", title: "Settings", type: .settings)
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
