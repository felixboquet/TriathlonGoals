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
    @Published private(set) var error: GoalsError?
    @Published private(set) var isLoading = false
    @Published var showingCreateModal = false
    let navigationTitle = "Objectifs"
    
    enum Action {
        case retry
        case create
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        goalService: GoalServiceProtocol = GoalService()
    ) {
        self.userService = userService
        self.goalService = goalService
        observeGoals()
    }
    
    func send(action: Action) {
        switch action {
        case .retry:
            observeGoals()
        case .create:
            showingCreateModal = true
        }
    }
    
    private func observeGoals() {
        isLoading = true
        userService.getCurrentUser()
            .compactMap { $0?.uid }
            .flatMap { [weak self] userId -> AnyPublisher<[Goal], GoalsError> in
                guard let me = self else {
                    return Fail(error: .default()).eraseToAnyPublisher()
                }
                return me.goalService.observeGoals(userId: userId)
            }
            .sink { [weak self] completion in
                guard let me = self else {
                    return
                }
                me.isLoading = false
                switch completion {
                case let .failure(error):
                    me.error = error
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] goals in
                guard let me = self else {
                    return
                }
                me.isLoading = false
                me.error = nil
                me.showingCreateModal = false
                me.itemViewModels = goals.map {
                    .init($0) { [weak self] id in
                        self?.deleteGoal(id)
                    } }
            }
            .store(in: &cancellables)
    }
    
    private func deleteGoal(_ goalId: String) {
        goalService.deleteGoal(goalId)
            .sink { [weak self] completion in
                
                guard let me = self else {
                    return
                }
                
                switch completion {
                case let .failure(error):
                    me.error = error
                case .finished:
                    break
                }
                
            } receiveValue: { [weak self] _ in
                guard let me = self else {
                    return
                }
                me.error = nil
            }
            .store(in: &cancellables)
    }
}
