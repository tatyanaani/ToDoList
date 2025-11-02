//
//  ItemModel.swift
//  ToDoList
//
//  Created by Tatyana on 23/10/2025.
//

import Foundation

// immutable struct, all of the items are "let", this way we're sure, that we update all the logic just within func updateCompletion
//add Codable, so that we can convert it to json, decode and encode it
struct ItemModel: Identifiable, Codable {
    let id: String
//    let id: String = UUID().uuidString // UUID is a buid in function that will create a random ID, .uuidString - to conform it to String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}


