//
//  GoalItemViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 27/10/2020.
//

import Foundation

struct GoalItemViewModel: Identifiable {
    
    private let goal: Goal
    private let currentDistance = 22.5
    private let onDelete: (String) -> Void
    
    init(
        _ goal: Goal,
        onDelete: @escaping (String) -> Void
    ) {
        self.goal = goal
        self.onDelete = onDelete
    }
    
    var id: String {
        goal.id ?? ""
    }
    
    var title: String {
        goal.activity.capitalized
    }
    
    var iconName: String {
        
        let activityType = ActivityType(rawValue: goal.activity)
        
        switch activityType {
        case .run:
            return "run"
        case .bike:
            return "bike"
        case .swim:
            return "swim"
        default:
            return ""
        }
    }
    
    enum ActivityType: String {
        case run = "Course à pieds"
        case bike = "Vélo"
        case swim = "Natation"
    }
    
    var progressCircleViewModel: ProgressCircleViewModel {
        let percentage = Double(currentDistance) / Double(totalDistanceValue)
            
        return .init(title: statusText, percentageComplete: percentage)
    }
    
    var statusText: String {
        if (!isComplete) {
            return "\(currentDistance) / \(goal.distance)km"
        } else {
            return "Terminé"
        }
    }
    
    var remainingDaysText: String {
        let dayNumber = daysFromStart + 1
        let remainingDays = goal.time - dayNumber
        if (remainingDays <= 0) {
            return "Terminé"
        } else {
            return "\(remainingDays) jours restants"
        }
    }
    
    var totalDistanceValue: Float {
        goal.distance
    }
    
    var currentDistanceValue: Float {
        Float(currentDistance)
    }
    
    private var daysFromStart: Int {
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: goal.startDate, to: Date()).day else {
            return 0
        }
        
        return abs(daysFromStart)
    }
    
    private var isComplete: Bool {
        Float(currentDistance) >= totalDistanceValue
    }
    
    func tappedDelete() {
        if let id = goal.id {
            onDelete(id)
        }
    }
}
