//
//  ContentView.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI

struct LandingView: View {
    
    @State private var isActive = false
    
    var body: some View {
        
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.18)
                    Text("Objectifs Triathlon")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundColor(.white)
                    Spacer()
                    
                    NavigationLink(
                        destination: CreateGoalsView(),
                        isActive: $isActive) {
                        Button(action: {
                            isActive = true
                        }) {
                            HStack(spacing: 8) {
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                Text("Créer un objectif")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }.padding(16)
                        .buttonStyle(PrimaryButtonStyle())
                    }
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
