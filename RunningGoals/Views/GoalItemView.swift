//
//  GoalItemView.swift
//  RunningGoals
//
//  Created by Féfé on 03/11/2020.
//

import SwiftUI

struct GoalItemView: View {
    
    private let viewModel: GoalItemViewModel
    
    init(viewModel: GoalItemViewModel) {
        self.viewModel = viewModel
    }
    
    var titleRow: some View {
        HStack {
            Image(viewModel.iconName)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "trash").onTapGesture {
                viewModel.tappedDelete()
            }
        }
    }
    
    var distanceRow: some View {
        HStack {
            ProgressCircleView(viewModel: viewModel.progressCircleViewModel)
                .padding(.vertical, 24)
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
