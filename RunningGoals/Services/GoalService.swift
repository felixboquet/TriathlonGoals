//
//  GoalService.swift
//  RunningGoals
//
//  Created by Féfé on 23/10/2020.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol GoalServiceProtocol {
    func create(_ goal: Goal) -> AnyPublisher<Void, Error>
}

final class GoalService: GoalServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func create(_ goal: Goal) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("goals").addDocument(from: goal) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
}
