//
//  CreateGoalsViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateGoalsViewModel: ObservableObject {
   
    var navigationBarTitle = "Créer un objectif"
    
    @Published var activityDropdown = GoalPartViewModel(type: .activity)
    @Published var unitDropdown = GoalPartViewModel(type: .unit)
    @Published var distanceText = ""
    @Published var durationText = ""
    
    @Published var error: GoalsError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let goalService: GoalServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createGoal
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        goalService: GoalServiceProtocol = GoalService()
    ) {
        self.userService = userService
        self.goalService = goalService
    }
    
    func send(action: Action) {
        switch action {
        
        case .createGoal:
            isLoading = true
            getCurrentUserId().flatMap { userId -> AnyPublisher<Void, GoalsError> in
                return self.createGoal(userId: userId)
            }.sink { completion in
                self.isLoading = false
                
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("Finished")
                }
            } receiveValue: { _ in
                print("Success")
            }.store(in: &cancellables)

        }
    }
    
    private func createGoal(userId: UserId) -> AnyPublisher<Void, GoalsError> {
        guard let activity = activityDropdown.text,
              let unit = unitDropdown.text else {
            return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
        }
        
        let goal = Goal(
            activity: activity,
            distance: (distanceText as NSString).floatValue,
            time: (durationText as NSString).integerValue,
            unit: unit,
            userId: userId,
            startDate: Date()
        )
        
        return goalService.create(goal).eraseToAnyPublisher()
    }
    
    private func getCurrentUserId() -> AnyPublisher<UserId, GoalsError> {
        return userService.getCurrentUser().flatMap { user -> AnyPublisher<UserId, GoalsError> in
            if let userId = user?.uid {
                return Just(userId)
                    .setFailureType(to: GoalsError.self)
                    .eraseToAnyPublisher()
            } else {
                return self.userService.signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateGoalsViewModel {
    struct GoalPartViewModel: DropdownItemProtocol, PrimaryTextFieldProtocol {
        
        var fieldValue: String = ""
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        
        private var type: GoalPartType
        
        init(type: GoalPartType) {
            
            switch type {
            case .activity:
                self.options = ActivityOption.allCases.map { $0.toDropdownOption }
                
            case .unit:
                self.options = UnitOption.allCases.map { $0.toDropdownOption }
            }
            
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum GoalPartType: String, CaseIterable {
            case activity = "Activité"
            case unit = "Unité"
        }
        
        enum ActivityOption: String, CaseIterable, DropdownOptionProtocol {
            case running = "Course à pieds"
            case swimming = "Natation"
            case biking = "Vélo"
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized)
            }
        }
        
        enum UnitOption: String, CaseIterable, DropdownOptionProtocol {
            case day = "Jours"
            case week = "Semaines"
            case month = "Mois"
            case year = "Années"
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized)
            }
        }
        
    }
}

extension CreateGoalsViewModel.GoalPartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
}
