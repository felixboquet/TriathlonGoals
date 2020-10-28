//
//  GoalsError.swift
//  RunningGoals
//
//  Created by Féfé on 23/10/2020.
//

import Foundation

enum GoalsError: LocalizedError {
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "Something went wrong"
        
        }
    }
}
