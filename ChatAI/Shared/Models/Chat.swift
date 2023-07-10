//
//  Chat.swift
//  ChatAI
//
//  Created by Magdalena Samuel on 6/29/23.
//

import Foundation

struct Chat: Identifiable, Hashable {
    let id = UUID()
    let question: String
    let answer: String
}
