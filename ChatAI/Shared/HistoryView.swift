//
//  HistoryView.swift
//  ChatGPTApp
//
//  Created by Mohammad Azam on 3/15/23.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: true)])
    private var historyItemResults: FetchedResults<ChatItems>
    
    var body: some View {
        List(historyItemResults) { chatItem in
            Text(chatItem.question ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    model.query = Chat(question: chatItem.question ?? "", answer: chatItem.answer ?? "")
                    #if os(iOS)
                        dismiss()
                    #endif
                }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(Model())
    }
}
