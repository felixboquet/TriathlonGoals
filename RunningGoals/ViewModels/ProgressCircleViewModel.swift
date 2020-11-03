//
//  ProgressCircleViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 03/11/2020.
//

import Foundation

struct ProgressCircleViewModel {
    let title: String
    let percentageComplete: Double
    
    var shouldShowTitle: Bool {
        percentageComplete <= 1
    }
}
