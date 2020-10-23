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
            getCurrentUserId().flatMap { userId -> AnyPublisher<Void, Error> in
                return self.createGoal(userId: userId)
            }.sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { _ in
                print("Success")
            }.store(in: &cancellables)

        }
    }
    
    private func createGoal(userId: UserId) -> AnyPublisher<Void, Error> {
        guard let activity = activityDropdown.text,
              let unit = unitDropdown.text else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        
        let goal = Goal(
            activity: activity,
            distance: 10,
            time: 1,
            unit: unit,
            userId: userId,
            startDate: Date()
        )
        
        return goalService.create(goal).eraseToAnyPublisher()
    }
    
    private func getCurrentUserId() -> AnyPublisher<UserId, Error> {
        return userService.getCurrentUser().flatMap { user -> AnyPublisher<UserId, Error> in
            if let userId = user?.uid {
                return Just(userId)
                    .setFailureType(to: Error.self)
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
