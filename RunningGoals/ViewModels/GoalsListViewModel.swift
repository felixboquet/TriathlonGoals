//
//  GoalsListViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 27/10/2020.
//

import Combine

final class GoalsListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let goalService: GoalServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels = [GoalItemViewModel] ()
    
    let navigationTitle = "Objectifs"
    
    init(
        userService: UserServiceProtocol = UserService(),
        goalService: GoalServiceProtocol = GoalService()
    ) {
        self.userService = userService
        self.goalService = goalService
        observeGoals()
    }
    
    private func observeGoals() {
        userService.getCurrentUser()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<[Goal], GoalsError> in
                return self.goalService.observeGoals(userId: userId)
            }
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { (goals) in
                self.itemViewModels = goals.map { .init($0) }
            }
            .store(in: &cancellables)
    }
}
