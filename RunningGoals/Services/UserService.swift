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
    func signInAnonymously() -> AnyPublisher<User, Error>
}

final class UserService: UserServiceProtocol {
    
    func getCurrentUser() -> AnyPublisher<User?, Never> {
        Just(Auth.auth().currentUser).eraseToAnyPublisher()
    }
    
    func signInAnonymously() -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    return promise(.failure(error))
                } else if let user = result?.user {
                    return promise(.success(user))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
