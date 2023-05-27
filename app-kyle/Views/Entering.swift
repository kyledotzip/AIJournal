//
//  ContentView.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/22.
//

import SwiftUI

struct Entering: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .position(x: 200,y: 200)
                Button("Enter") {
                    appState.hasEntered = true
                }
                .foregroundColor(.white)
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .background(.black)
                .controlSize(.large)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1))
                Spacer()
                    .frame(height: 200)
                    .padding()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Entering()
    }
}
