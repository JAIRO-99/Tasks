//
//  TaskModel.swift
//  Tasks
//
//  Created by New on 11/03/24.
//

import Foundation

struct TaskModel: Identifiable,Codable{
    let id: String
    var isFavorite: Bool
    let description: String
    
    init(id: String = UUID().uuidString, isFavorite: Bool = false, description: String) {
        self.id = id
        self.isFavorite = isFavorite
        self.description = description
    }
    
}
