//
//  String+Extentions.swift
//  ChatAI
//
//  Created by Magdalena Samuel on 6/28/23.
//

import Foundation
// prevent white spaces and empty string submitions

extension String {
    var hasWhiteSpacesOrIsEmpt: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
