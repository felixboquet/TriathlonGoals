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
    @Published var signupPushed = false
    let navigationTitle = "Paramètres"
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .account:
            guard userService.currentUser?.email == nil else {
                return
            }
            signupPushed = true
        case .mode:
            isDarkMode = !isDarkMode
            buildItems()
        case .logout:
            userService.logout().sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
        default:
            break
            
        //        case .privacy:
        
        
        }
    }
    
    private func buildItems(){
        itemViewModels = [
            .init(title: userService.currentUser?.email ?? "Créer un compte", iconName: "person.circle", type: .account),
            .init(title: "Passer en thème \(isDarkMode ? "clair" : "sombre")", iconName: "lightbulb", type: .mode),
            .init(title: "Vie privée", iconName: "shield", type: .privacy)
        ]
        
        if userService.currentUser?.email != nil {
            itemViewModels += [.init(title: "Déconnexion", iconName: "arrowshape.turn.up.left", type: .logout)]
        }
    }
    
    func onAppear() {
        buildItems()
    }
}
