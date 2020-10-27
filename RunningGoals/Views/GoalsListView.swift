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
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                    ForEach(viewModel.itemViewModels, id: \.self) { viewModel in
                        GoalItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }
        }.navigationTitle(viewModel.navigationTitle)
    }
}

struct GoalItemView: View {
    
    private let viewModel: GoalItemViewModel
    
    init(viewModel: GoalItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                Text(viewModel.statusText)
                Text(viewModel.remainingDaysText)
            }.padding()
        }
        .background(
            Rectangle()
                .fill(Color.darkPrimaryButton)
                .cornerRadius(5)
        ).padding()
        
    }
}
