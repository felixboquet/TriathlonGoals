//
//  PrimaryTextFieldStyle.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    
    var fillColor: Color = .darkPrimaryButton
    
    func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .font(.system(size: 28, weight: .semibold))
                .background(RoundedRectangle(
                    cornerRadius: 8
                ).fill(fillColor))
                .foregroundColor(.white)
        }
    
}
