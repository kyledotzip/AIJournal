//
//  Sidebar.swift
//  app-kyle
//
//  Created by Kyle House on 2023/05/26.
//

import SwiftUI

struct Sidebar: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var noteState: NoteState
    
    @Binding var isSidebarVisible: Bool
    @Binding var notes: [Notes]
    @Binding var title: String
    @Binding var text: String
    
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
                
                VStack(alignment: .leading, spacing: 20) {
                    userProfile
                    Divider()
                        .overlay(.white)
                        .padding(.horizontal, 30)
                    List {
                        Button() {
                            appState.toggleNotesOff()
                            isSidebarVisible.toggle()
                            // Temporary -- pretty much not much to be done
                        } label: {
                            Text("-Chat with AI-")
                                .font(.title2)
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(height: 40)
                        .listRowBackground(menuColor)
                        .listRowSeparatorTint(.white)
                        ForEach(notes) { note in
                            Button() {
                                noteState.title = note.title
                                noteState.text = note.text
                                appState.toggleNotesOn()
                                isSidebarVisible.toggle()
                                // Temporary
                            } label: {
                                Text(note.title)
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                            .frame(height: 40)
                            .listRowBackground(menuColor)
                            .listRowSeparatorTint(.white)
                        }
                        Button() {
                            appState.toggleNotesOn()
                            isSidebarVisible.toggle()
                            // Temporary new chat functionality
                        } label: {
                            Text("+ New Note")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        .frame(height: 40)
                        .listRowBackground(menuColor)
                        .listRowSeparatorTint(.white)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
                .padding(.top, 80)
                
            }
            .frame(width: sidebarWidth)
            .offset(x: isSidebarVisible ? 0 : -sidebarWidth)
            .animation(.default, value: isSidebarVisible)
            Spacer()
        }
    }
    var userProfile: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("Placeholder2")
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .center)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 2)
                    }
                    .aspectRatio(3 / 2, contentMode: .fill)
                    .shadow(radius: 4)
                Spacer()
            }
            VStack(alignment: .leading) {
                HStack() {
                    Spacer()
                    Text("Welcome")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                HStack() {
                    Spacer()
                    Text("Kyle")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title3)
                    Spacer()
                }
                
            }
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    
    static var previews: some View {
        Sidebar(isSidebarVisible: .constant(true), notes: .constant(Notes.sampleData), title: .constant(""), text: .constant(""))
            .environmentObject(NoteState())
    }
}

