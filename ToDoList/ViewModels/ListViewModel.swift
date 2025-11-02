//
//  ListViewModel.swift
//  ToDoList
//
//  Created by Tatyana on 23/10/2025.
//

/*
 CRUD FUNCTIONS
 
 create
 read
 update
 delete
 
 */

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        // any time we change ItemModel, didSet wil be called
        didSet{
            saveItems()
            // so if we do anything that affects items array (includes deleteItem, addItem, moveItem func - update data), we will save these changes
        }
    }
    let itemsKey = "items_list"
    
    
    
    init(){
        getItems()
    }
    func getItems(){
       /*just so that we see first item in our list
       let newItem = [
            ItemModel(title: "Buy milk", isCompleted: false),
           ItemModel(title: "Learn SwiftUI", isCompleted: true),
            ItemModel(title: "Go for a walk", isCompleted: false)
       ]
       items.append(contentsOf: newItem) */
       guard let data = UserDefaults.standard.data(forKey: itemsKey) else { return }
       // now we need to convert (decode) data from json data to array of ItemModels
       guard let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else { return }
        
        // we can rewrite it this way
        /*
         guard
              let data = UserDefaults.standard.data(forKey: itemsKey)
              let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
         else { return }
         */
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItemStatus(item: ItemModel){
        
        /*
         if let index = items.firstIndex(where: { (existingItem) -> Bool in
            return existingItem.id == item.id
        }) {
            
        }
         */
        
        //the same, but less code - we do it so that he updated item has the same ID, as it had before
        if let index = items.firstIndex(where: { $0.id == item.id }){
            items[index] = item.updateCompletion()
        }
        
    }
    
    func saveItems(){
        //if we where inside view, we would use appStorage, but as we're within class, we need to use UserDefaults in order to save data
        //first we need to convert array of ItemModels to json data. It's a data blob
        // encoding ItemModel into data
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    
    
    
//    func deleteTodoItems(at offsets: IndexSet) {
//            let todoItems = items.filter { !$0.isCompleted }
//            offsets.forEach { index in
//                if let realIndex = items.firstIndex(where: { $0.id == todoItems[index].id }) {
//                    items.remove(at: realIndex)
//                }
//            }
//        }
//
//        func deleteDoneItems(at offsets: IndexSet) {
//            let doneItems = items.filter { $0.isCompleted }
//            offsets.forEach { index in
//                if let realIndex = items.firstIndex(where: { $0.id == doneItems[index].id }) {
//                    items.remove(at: realIndex)
//                }
//            }
//        }
    
    
    
    
    
//    func moveTodoItems(from source: IndexSet, to destination: Int) {
//            let todoItems = items.filter { !$0.isCompleted }
//            var sourceIndices: [Int] = []
//            
//            for index in source {
//                if let realIndex = items.firstIndex(where: { $0.id == todoItems[index].id }) {
//                    sourceIndices.append(realIndex)
//                }
//            }
//            
//            for from in sourceIndices.sorted(by: >) {
//                items.move(fromOffsets: IndexSet(integer: from),
//                           toOffset: destination > from ? destination - 1 : destination)
//            }
//        }
//        
//        func moveDoneItems(from source: IndexSet, to destination: Int) {
//            let doneItems = items.filter { $0.isCompleted }
//            var sourceIndices: [Int] = []
//            
//            for index in source {
//                if let realIndex = items.firstIndex(where: { $0.id == doneItems[index].id }) {
//                    sourceIndices.append(realIndex)
//                }
//            }
//            
//            for from in sourceIndices.sorted(by: >) {
//                items.move(fromOffsets: IndexSet(integer: from),
//                           toOffset: destination > from ? destination - 1 : destination)
//            }
//        }
}
