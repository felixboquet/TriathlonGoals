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
        
        Publishers.CombineLatest($emailText, $passwordText)
            .map { [weak self] email, password in
                guard let me = self else { return false }
                return me.isValidEmail(email) && me.isValidPassword(password)
            }.assign(to: &$isValid)
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
            userService.login(email: emailText, password: passwordText).sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
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
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) && email.count > 5
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 5
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
