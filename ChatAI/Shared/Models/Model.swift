//
//  Model.swift
//  ChatAI
//
//  Created by Magdalena Samuel on 6/29/23.
//

import Foundation

class Model: ObservableObject {
    
    @Published var queries: [Chat] = []
    @Published var query = Chat(question: "", answer: "") //will become selected query 
    
    func saveChat(_ chat: Chat) throws {
        //use CD to save
        let viewContext = CoraDataManager.shared.presistentContainer.viewContext
        let chatItems = ChatItems(context: viewContext)
        chatItems.question = chat.question
        chatItems.answer = chat.answer
        chatItems.dateCreated = Date()
        try viewContext.save()
        
    }
}
