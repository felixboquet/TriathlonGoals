//
//  GoalItemViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 27/10/2020.
//

import Foundation

struct GoalItemViewModel: Hashable {
    private let goal: Goal
    
    var title: String {
        goal.activity.capitalized
    }
    
    var statusText: String {
        return "0km / \(goal.distance)km"
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
    
    init(_ goal: Goal) {
        self.goal = goal
    }

    private var daysFromStart: Int {
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: goal.startDate, to: Date()).day else {
            return 0
        }
        
        return abs(daysFromStart)
    }
}
