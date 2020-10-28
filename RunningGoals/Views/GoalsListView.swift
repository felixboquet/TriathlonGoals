//
//  GoalsListView.swift
//  RunningGoals
//
//  Created by Féfé on 27/10/2020.
//

import SwiftUI

struct GoalsListView: View {
    
    @StateObject private var viewModel = GoalsListViewModel()
    
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
                    ForEach(viewModel.itemViewModels, id: \.self) { viewModel in
                        GoalItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }.padding(16)
        }
        .sheet(isPresented: $viewModel.showingCreateModal) {
            NavigationView {
                CreateGoalsView()
            }
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle").imageScale(.large)
        })
        .navigationTitle(viewModel.navigationTitle)
    }
}

struct GoalItemView: View {
    
    private let viewModel: GoalItemViewModel
    
    init(viewModel: GoalItemViewModel) {
        self.viewModel = viewModel
    }
    
    var titleRow: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash")
        }
    }
    
    var distanceRow: some View {
        HStack {
            ProgressView(viewModel.statusText, value: viewModel.currentDistanceValue, total: viewModel.totalDistanceValue)
                .font(.system(size: 12, weight: .semibold))
                .padding(18)
        }
    }
    
    var remainingDaysRow: some View {
        HStack {
            Text(viewModel.remainingDaysText)
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                titleRow
//                Text(viewModel.statusText)
//                    .font(.system(size: 12, weight: .semibold))
//                    .padding(18)
                distanceRow
                remainingDaysRow
            }.padding()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButton)
                .cornerRadius(5)
        )
        
    }
}
