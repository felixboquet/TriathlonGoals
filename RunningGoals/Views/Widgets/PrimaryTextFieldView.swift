//
//  PrimaryTextField.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct PrimaryTextFieldView: View {
    
    @State var headerTitle: String
    @Binding var value: String
    
    var body: some View {
        VStack {
            HStack {
                Text(headerTitle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 8)
            TextField("", text: $value).textFieldStyle(PrimaryTextFieldStyle())
        }.padding(20)
    }
    
}
