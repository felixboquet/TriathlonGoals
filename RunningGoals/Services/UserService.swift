//
//  UserService.swift
//  RunningGoals
//
//  Created by Féfé on 23/10/2020.
//

import Combine
import FirebaseAuth

protocol UserServiceProtocol {
    func getCurrentUser() -> AnyPublisher<User?, Never>
    func signInAnonymously() -> AnyPublisher<User, GoalsError>
    func observeAuthChanges() -> AnyPublisher<User?, Never>
    func linkAccount(email: String, password: String) -> AnyPublisher<Void, GoalsError>
}

final class UserService: UserServiceProtocol {
    
    func getCurrentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, GoalsError> {
        return Future<User, GoalsError> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    return promise(.failure(.auth(description: error.localizedDescription)))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func observeAuthChanges() -> AnyPublisher<User?, Never> {
        Publishers.AuthPublisher().eraseToAnyPublisher()
    }
    
    func linkAccount(email: String, password: String) -> AnyPublisher<Void, GoalsError> {
        let emailCredential = EmailAuthProvider.credential(withEmail: email, password: password)
        return Future<Void, GoalsError> { promise in
            Auth.auth().currentUser?.link(with: emailCredential) { result, error in
                if let error = error {
                    return promise(.failure(.default(description: error.localizedDescription)))
                } else if let user = result?.user {
                    Auth.auth().updateCurrentUser(user) { error in
                        if let error = error {
                            return promise(.failure(.default(description: error.localizedDescription)))
                        } else {
                            return promise(.success(()))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
