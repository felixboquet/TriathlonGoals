//
//  CreateGoalsView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct CreateGoalsView: View {
    
    @StateObject var viewModel = CreateGoalsViewModel()
    @State private var isActive = false
    @State private var text = ""
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropDownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                PrimaryTextFieldView(headerTitle: "Distance (km)", value: $text)
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
