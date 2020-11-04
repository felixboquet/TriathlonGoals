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
    func create(_ goal: Goal) -> AnyPublisher<Void, GoalsError>
    func observeGoals(userId: UserId) -> AnyPublisher<[Goal], GoalsError>
    func deleteGoal(_ goalId: String) -> AnyPublisher<Void, GoalsError>
    func addActivitiesToGoal(_ goalId: String, activities: [Activity]) -> AnyPublisher<Void, GoalsError>
}

final class GoalService: GoalServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func create(_ goal: Goal) -> AnyPublisher<Void, GoalsError> {
        return Future<Void, GoalsError> { promise in
            do {
                _ = try self.db.collection("goals").addDocument(from: goal) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(.default()))
            }
        }.eraseToAnyPublisher()
    }
    
    func observeGoals(userId: UserId) -> AnyPublisher<[Goal], GoalsError> {
        let query = db.collection("goals").whereField("userId", isEqualTo: userId).order(by: "startDate", descending: true)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap { snapShot -> AnyPublisher<[Goal], GoalsError> in
                do {
                    let goals = try snapShot.documents.compactMap {
                        try $0.data(as: Goal.self)
                    }
                    return Just(goals).setFailureType(to: GoalsError.self).eraseToAnyPublisher()
                } catch {
                    return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func deleteGoal(_ goalId: String) -> AnyPublisher<Void, GoalsError> {
        return Future<Void, GoalsError> { promise in
            self.db.collection("goals").document(goalId).delete { error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addActivitiesToGoal(_ goalId: String, activities: [Activity]) -> AnyPublisher<Void, GoalsError> {
        return Future<Void, GoalsError> { promise in
            self.db.collection("goals").document(goalId).updateData(
                ["activities": activities.map {
                    return [$0.id]
                }]
            ) { error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
