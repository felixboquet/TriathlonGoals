//
//  CreateGoalsView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct CreateGoalsView: View {
    
    @StateObject var viewModel = CreateGoalsViewModel()
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                DropDownView(viewModel: $viewModel.activityDropdown)
                PrimaryTextFieldView(headerTitle: "Distance (km)", value: $viewModel.distanceText)
                PrimaryTextFieldView(headerTitle: "Temps", value: $viewModel.durationText)
                DropDownView(viewModel: $viewModel.unitDropdown)
                Spacer()
                Button(action: {
                    viewModel.send(action: .createGoal)
                }) {
                    Text("Créer")
                        .font(.system(size: 24, weight: .medium))
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    mainContentView
                }
            }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
                Alert(
                    title: Text("Erreur"),
                    message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                    dismissButton: .default(Text("OK"), action: {
                        viewModel.error = nil
                    })
                )
            }
            .navigationBarTitle(viewModel.navigationBarTitle)
            .padding(.bottom, 16)
        }
    }
    
}

