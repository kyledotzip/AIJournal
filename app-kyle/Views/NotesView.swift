//
//  NotesView.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/29.
//

import SwiftUI

struct NotesView: View {
    
    @State private var title = ""
    @State private var text = ""
    @State private var isSidebarOpened = false
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Button() {
                    isSidebarOpened.toggle()
                } label: {
                    Image("menu-icon")
                }
                TextEditor(text: $title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .scrollContentBackground(.hidden)
                    .placeholder(when: title.isEmpty) {
                        Text("Title")
                            .foregroundStyle(LinearGradient(
                                colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                            ))
                            .opacity(0.7)
                            .font(.largeTitle)
                            .offset(x: 5)
                    }
                
                Divider()
                    .overlay(.gray)
                    .padding(.horizontal, 10)
                TextEditor(text: $text)
                    .frame(height: 625)
                    .font(.title2)
                    .foregroundColor(.white)
                    .scrollContentBackground(.hidden)
                    .placeholder(when: text.isEmpty) {
                        Text("Put your thoughts here...")
                            .foregroundStyle(LinearGradient(
                                colors: [.gray, .darkgray], startPoint: .leading, endPoint: .trailing
                            ))
                            .opacity(0.7)
                            .font(.title2)
                            .offset(x: 5,y: -290)
                        
                    }

            }
            Sidebar(isSidebarVisible: $isSidebarOpened, notes: .constant(Notes.sampleData))
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
