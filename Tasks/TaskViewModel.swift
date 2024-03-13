//
//  TaskViewModel.swift
//  Tasks
//
//  Created by New on 11/03/24.
//

import Foundation
import SwiftUI


 class TaskViewModel: ObservableObject{
 
     @Published var task: [TaskModel] = []
     
     func saveTask(description: String){
         let newTask = TaskModel(description: description)
         task.insert(newTask, at: 0)
         encodeAndSaveTask()
     }
     
     func deleteTask(id: String){
         task.removeAll(where: {$0.id == id})
     }
     
     func encodeAndSaveTask(){ // codificando notas
         if let encoded = try? JSONEncoder().encode(task){
             UserDefaults.standard.set(encoded, forKey: "task")
         }
     }
     
     func decodeAllTask() -> [TaskModel]{ //descodificando notas
         if let data = UserDefaults.standard.object(forKey: "task") as? Data {
             if let tasks = try? JSONDecoder().decode([TaskModel].self, from: data){
                 return tasks
             }
         }
         return []
     }
     
     func countTask() -> String{
         "\(task.count)"
     }
     func addFavorites(task: Binding<TaskModel>){
         task.wrappedValue.isFavorite = !task.wrappedValue.isFavorite
         encodeAndSaveTask()
     }
}
