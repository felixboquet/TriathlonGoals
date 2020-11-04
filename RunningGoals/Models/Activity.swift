//
//  Activity.swift
//  RunningGoals
//
//  Created by Féfé on 03/11/2020.
//

import FirebaseFirestoreSwift

struct Activity: Codable {
    @DocumentID var id: String?
    let date: Date
    let distance: Float
    let goals: [String]
}
