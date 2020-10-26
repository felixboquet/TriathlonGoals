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
    
    var mainContentView: some View {
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
