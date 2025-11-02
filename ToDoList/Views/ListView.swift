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
                    
                    Section(header: Text("To do ❤️")) {
                        ForEach(listViewModel.items) { item in
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
                    
                    
                    Section(header: Text("Done ⭐️")) {
                        
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


