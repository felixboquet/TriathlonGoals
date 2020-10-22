//
//  CreateGoalsView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct CreateGoalsView: View {
    
    @State private var isActive = false
    
    var body: some View {
        ScrollView {
            VStack {
                DropDownView()
                DropDownView()
                DropDownView()
                DropDownView()
                Spacer()
                NavigationLink(
                    destination: ReminderView(),
                    isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("Suivant")
                            .font(.system(size: 24, weight: .medium))
                    }
                }
            }.navigationBarTitle("Créer un objectif")
            .padding(.bottom, 16)
        }
    }
    
}
