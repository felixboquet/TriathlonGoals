//
//  GoalsListView.swift
//  RunningGoals
//
//  Created by Féfé on 27/10/2020.
//

import SwiftUI

struct GoalsListView: View {
    
    @StateObject private var viewModel = GoalsListViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Réessayer") {
                        viewModel.send(action: .retry)
                    }
                    .padding(8)
                    .background(Rectangle().fill(Color.red).cornerRadius(5))
                }
            } else {
                mainContentView
            }
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 16), .init(.flexible())], spacing: 16) {
                    ForEach(viewModel.itemViewModels, id: \.id) { viewModel in
                        GoalItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }.padding(16)
        }
        .sheet(isPresented: $viewModel.showingCreateModal) {
            NavigationView {
                CreateGoalsView()
            }.preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle").imageScale(.large)
        })
        .navigationTitle(viewModel.navigationTitle)
    }
}
