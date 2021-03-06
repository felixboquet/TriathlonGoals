//
//  LoginSignupView.swift
//  RunningGoals
//
//  Created by Féfé on 02/11/2020.
//

import SwiftUI

struct LoginSignupView: View {
    
    @ObservedObject var viewModel: LoginSignupViewModel
    
    var emailTextField: some View {
        TextField(viewModel.emailPlaceholder, text: $viewModel.emailText)
            .modifier(TextFieldCustomRoundedStyle())
            .autocapitalization(.none)
    }
    
    var passwordTextField: some View {
        SecureField(viewModel.passwordPlaceholder, text: $viewModel.passwordText)
            .modifier(TextFieldCustomRoundedStyle())
            .autocapitalization(.none)
    }
    
    var actionButton: some View {
        Button(viewModel.buttontitle) {
            viewModel.tappedActionButton()
        }.padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemBlue))
        .cornerRadius(16)
        .padding()
        .disabled(!viewModel.isValid)
        .opacity(viewModel.isValid ? 1 : 0.4)
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subtitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer().frame(height: 40)
            emailTextField
            passwordTextField
            actionButton
            Spacer()
        }.padding()
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginSignupView(viewModel: .init(mode: .login, isPushed: .constant(false)))
        }.environment(\.colorScheme, .dark)
    }
}
