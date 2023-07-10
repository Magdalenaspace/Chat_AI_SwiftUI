//
//  ChatAI_macOSApp.swift
//  ChatAI_macOS
//
//  Created by Magdalena Samuel on 6/27/23.
//

import SwiftUI

@main
struct macOS_ChatGPTApp: App {
    
        //for adapting the application delegate
   @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
                .environment(\.managedObjectContext, CoraDataManager.shared.presistentContainer.viewContext)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView().environment(\.managedObjectContext, CoraDataManager.shared.presistentContainer.viewContext)
            .environmentObject(Model())
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "brain", accessibilityDescription: "Brain")
            statusButton.action = #selector(togglePopover)
        }
        
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 600, height: 600)
        self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: contentView)
        
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
}
