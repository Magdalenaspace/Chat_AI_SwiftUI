//
//  ChatAI_iOSApp.swift
//  ChatAI_iOS
//
//  Created by Magdalena Samuel on 6/27/23.
//

import SwiftUI

@main
struct ChatAI_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //inject the view
                .environmentObject(Model())
                .environment(\.managedObjectContext,CoraDataManager.shared.presistentContainer.viewContext)
        }
    }
}
