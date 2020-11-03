//
//  Goal.swift
//  RunningGoals
//
//  Created by Féfé on 23/10/2020.
//

import Foundation
import FirebaseFirestoreSwift

struct Goal: Codable {
    @DocumentID var id: String?
    let activity: String
    let distance: Float
    let time: Int
    let unit: String
    let userId: String
    let startDate: Date
}
