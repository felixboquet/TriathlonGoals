//
//  CreateGoalsView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct CreateGoalsView: View {
    
    @StateObject var viewModel = CreateGoalsViewModel()
    @State private var text = ""
    
    var dropdownList: some View {
        Group {
            DropDownView(viewModel: $viewModel.activityDropdown)
            DropDownView(viewModel: $viewModel.unitDropdown)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                PrimaryTextFieldView(headerTitle: "Distance (km)", value: $text)
                Spacer()
                Button(action: {
                    viewModel.send(action: .createGoal)
                }) {
                    Text("Créer")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            
            .navigationBarTitle(viewModel.navigationBarTitle)
            .padding(.bottom, 16)
        }
    }
    
}
