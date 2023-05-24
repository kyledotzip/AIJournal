//
//  app_kyleApp.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/22.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var hasEntered: Bool
    
    init(hasEntered: Bool) {
        self.hasEntered = hasEntered
    }
}

@main
struct app_kyleApp: App {
    @ObservedObject var appState = AppState(hasEntered: false)
    
    var body: some Scene {
        WindowGroup {
            if appState.hasEntered {
                Main()
                    .environmentObject(appState)
            } else {
                Entering()
                    .environmentObject(appState)
            }


        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
