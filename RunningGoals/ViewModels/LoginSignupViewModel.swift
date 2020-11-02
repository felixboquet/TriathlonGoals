//
//  LoginSignupViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 02/11/2020.
//

import Foundation

final class LoginSignupViewModel: ObservableObject {
    
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    
    init(mode: Mode) {
        self.mode = mode
    }
    
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
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
