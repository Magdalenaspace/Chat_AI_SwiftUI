//
//  ContentView.swift
//  ChatAI_macOS
//
//  Created by Magdalena Samuel on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            HistoryView()
        } detail: {
            MainView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
