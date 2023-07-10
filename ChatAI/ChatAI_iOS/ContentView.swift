//
//  ContentView.swift
//  ChatAI_iOS
//
//  Created by Magdalena Samuel on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresnted: Bool = false
    
    var body: some View {
        NavigationStack{
            MainView().sheet(isPresented: $isPresnted, content: {
                NavigationStack {
                    HistoryView().navigationTitle("Chat History")
                }.background(Color.gray)
            }).toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresnted = true
                    } label: {
                        Text("Show Chat History")
                            .foregroundColor(Color.black).fontWeight(.bold)
                            .background(Color.gray.opacity(0.1))
                            
                    }
                }
            }
        }
    }
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext,CoraDataManager.shared.presistentContainer.viewContext)       .environmentObject(Model())
            .environmentObject(Model())
    }
}
