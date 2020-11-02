//
//  LoginSignupViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 02/11/2020.
//

import Combine
import SwiftUI

final class LoginSignupViewModel: ObservableObject {
    
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    @Binding var isPushed: Bool
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(
        mode: Mode,
        userService: UserServiceProtocol = UserService(),
        isPushed: Binding<Bool>
    ) {
        self.mode = mode
        self.userService = userService
        self._isPushed = isPushed
    }
    
    let emailPlaceholder = "Email"
    let passwordPlaceholder = "Mot de passe"
    
    var title: String {
        switch mode {
        case .login:
            return "Bon retour !"
        case .signup:
            return "Créer un compte"
        }
    }
    
    var subtitle: String {
        switch mode {
        case .login:
            return "Connexion par email"
        case .signup:
            return "Créer un compte par email"
        }
    }
    
    var buttontitle: String {
        switch mode {
        case .login:
            return "Se connecter"
        case .signup:
            return "Créer un compte"
        }
    }
    
    func tappedActionButton() {
        switch mode {
        case .login:
            print("login")
        case .signup:
            userService.linkAccount(email: emailText, password: passwordText).sink { [weak self] completion in
                guard let me = self else {
                    return
                }
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    me.isPushed = false
                    print("finished")
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
        }
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
