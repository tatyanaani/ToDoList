//
//  ListView.swift
//  ToDoList
//
//  Created by Tatyana on 23/10/2025.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
   
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
            else{
                List{
                    
                    let todoItems = listViewModel.items.filter { !$0.isCompleted }
                    
                        Section(header:
                                    Text("To do ❤️")
                            .font(.title.bold())
                            .foregroundStyle(.primary)
                            ) {
                            if todoItems.isEmpty {
                                Text ("You've done everything 🥳")
                                    .font(.headline)
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                            ForEach(listViewModel.items.filter { !$0.isCompleted }) { item in
                                ListRowView(item: item)
                                    .onTapGesture {
                                        withAnimation(.linear){
                                            //item.isCompleted.toggle()
                                            listViewModel.updateItemStatus(item: item)
                                        }
                                    }
                            }
                            .onDelete(perform: listViewModel.deleteItem)
                            .onMove(perform: listViewModel.moveItem)
                    }
                    
                    if listViewModel.items.contains(where: {$0.isCompleted}){
                        Section(header:
                                    Text("Done ⭐️")
                            .font(.title.bold())
                            .foregroundStyle(.primary)
                        ) {
                            ForEach(listViewModel.items.filter { $0.isCompleted }) { item in
                                ListRowView(item: item)
                                    .listRowBackground(Color.green.opacity(0.2))
                                    .onTapGesture {
                                        withAnimation(.linear){
                                            //item.isCompleted.toggle()
                                            listViewModel.updateItemStatus(item: item)
                                        }
                                    }
                            }
                            .onDelete(perform: listViewModel.deleteItem)
                            .onMove(perform: listViewModel.moveItem)
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle(Text("To-Do List 📝"))
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem (placement: .navigationBarTrailing) {
                NavigationLink("Add", destination: AddView())
            }
        }
    }
}

#Preview {
    NavigationStack{ // so that we see it as it'll be in the app
        ListView()
    }
    .environmentObject(ListViewModel())
}


