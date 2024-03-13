//
//  ContentView.swift
//  Tasks
//
//  Created by New on 11/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    
   @StateObject var taskViewModel = TaskViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Agrega una tarea")
                    .underline()
                
                TextEditor(text: $text)
                    .foregroundStyle(.blue)
                    .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 1)
                    )
                    .padding()
                
                Button("Agregar tarea"){
                    if !text.isEmpty{
                        taskViewModel.saveTask(description: text)
                    }
                        text = ""
                }
                .buttonStyle(.bordered)
                .padding()
                
                Spacer()
                
                List{
                    ForEach($taskViewModel.task,id: \.id){ $tasks in
                        HStack{
                            Text(tasks.description)
                            
                            Spacer()
                            
                            if tasks.isFavorite{
                                Text("⭐️")
                            }
                        }
                        .swipeActions(edge: .leading){
                            Button{
                                taskViewModel.deleteTask(id: tasks.id)
                            }label: {
                                Label("Borrar", systemImage: "trash.fill")
                                    .tint(.red)
                            }
                        }
                        .swipeActions(edge: .trailing){
                            Button{
                                taskViewModel.addFavorites(task: $tasks)
                            }label: {
                                Label("Borrar", systemImage: "star.fill")
                                    .tint(.yellow)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(taskViewModel.countTask())
            }
            
        }
       
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
