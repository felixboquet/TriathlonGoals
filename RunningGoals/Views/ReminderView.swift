//
//  ReminderView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct ReminderView: View {
    
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Spacer()
            DropDownView()
            Spacer()
            Button(action: {
                isActive = true
            }) {
                Text("Créer")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 16)
            
            Button(action: {
                isActive = true
            }) {
                Text("Passer")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
            
        }.navigationTitle("Rappel")
        .padding(.bottom, 16)
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReminderView()
        }
    }
}
