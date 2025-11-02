//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Tatyana on 23/10/2025.
//

import SwiftUI


/*
 MVVM Architecture
 
 Model - data points
 View - UI of our app
 ViewModel - the observable object or class (model) that manages data for the view
 
  */

@main
struct ToDoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel() // this is a new ListViewModel
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
