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
        TextField("Email", text: $viewModel.emailText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordTextField: some View {
        SecureField("Mot de passe", text: $viewModel.passwordText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var actionButton: some View {
        Button(viewModel.buttontitle) {
            
        }.padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemBlue))
        .cornerRadius(16)
        .padding()
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
            LoginSignupView(viewModel: .init(mode: .login))
        }.environment(\.colorScheme, .dark)
    }
}
