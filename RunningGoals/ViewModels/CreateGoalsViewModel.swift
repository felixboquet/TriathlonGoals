//
//  CreateGoalsViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI


final class CreateGoalsViewModel: ObservableObject {
    @Published var dropdowns: [GoalPartViewModel] = [
        .init(type: .activity),
        .init(type: .unit)
    ]
}

extension CreateGoalsViewModel {
    struct GoalPartViewModel: DropdownItemProtocol, PrimaryTextFieldProtocol {
        
        var fieldValue: String = ""
        
        var options: [DropdownOption]
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            options.first(where: { $0.isSelected })?.formatted ?? ""
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
                      formatted: rawValue.capitalized,
                      isSelected: self == .running)
            }
        }
        
        enum UnitOption: String, CaseIterable, DropdownOptionProtocol {
            case day = "Jours"
            case month = "Mois"
            case year = "Années"
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized,
                      isSelected: self == .day)
            }
        }
        
    }
}
