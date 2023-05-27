//
//  Sidebar.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/26.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var isSidebarVisible: Bool
    var sidebarWidth = UIScreen.main.bounds.size.width * 0.7
    var menuColor: Color = Color(.init(red: 29 / 255, green: 29 / 255, blue: 29 / 255, alpha: 1))
    
    var body: some View {
        
            ZStack() {
                
                GeometryReader { _ in
                    EmptyView()
                    
                }
                .background(.black.opacity(0.6))
                .opacity(isSidebarVisible ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
                .onTapGesture {
                    isSidebarVisible.toggle()
                }
                content
            }
            .edgesIgnoringSafeArea(.all)
    }
    var content: some View {
        
        HStack(alignment: .top) {
            
            ZStack(alignment: .top) {
                
                menuColor
                
            }
            .frame(width: sidebarWidth)
            .offset(x: isSidebarVisible ? 0 : -sidebarWidth)
            .animation(.default, value: isSidebarVisible)
            Spacer()
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    
    static var previews: some View {
        Sidebar(isSidebarVisible: .constant(true))
    }
}
