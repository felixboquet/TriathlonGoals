//
//  LandingViewModel.swift
//  RunningGoals
//
//  Created by Féfé on 29/10/2020.
//

import Foundation

final class LandingViewModel: ObservableObject {
    @Published var loginSignupPushed = false
    @Published var createPushed = false
    
    let title = "Objectifs sportifs"
    let createButtonTitle = "Créer un objectif"
    let createButtonImageName = "plus.circle"
    let alreadyHaveAccountTitle = "J'ai déjà un compte"
}
