//
//  ContentView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct LandingView: View {
    
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(size: 64, weight: .medium))
            .foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            viewModel.createPushed = true
        }) {
            HStack(spacing: 8) {
                Spacer()
                Image(systemName: viewModel.createButtonImageName)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                Text(viewModel.createButtonTitle)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                Spacer()
            }
        }.padding(16)
        .buttonStyle(PrimaryButtonStyle())
    }
    
    var alreadyHaveAccountButton: some View {
        Button(viewModel.alreadyHaveAccountTitle) {
            viewModel.loginSignupPushed = true
        }.foregroundColor(.white)
    }
    
    var body: some View {
        
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.18)
                    title
                    Spacer()
                    
                    NavigationLink(
                        destination: CreateGoalsView(),
                        isActive: $viewModel.createPushed) {}
                    createButton
                    
                    NavigationLink(
                        destination: LoginSignupView(viewModel: .init(mode: .login, isPushed: $viewModel.loginSignupPushed)),
                        isActive: $viewModel.loginSignupPushed) {}
                    alreadyHaveAccountButton
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .background(
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                )
                
            }
        }.accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 8")
        LandingView().previewDevice("iPhone 11 Pro")
        LandingView().previewDevice("iPhone 11 Pro Max")
    }
}
