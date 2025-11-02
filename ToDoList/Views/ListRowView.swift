//
//  ListRowView.swift
//  ToDoList
//
//  Created by Tatyana on 23/10/2025.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .orange)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    
    var item1 = ItemModel(title: "Test", isCompleted: false)
    var item2 = ItemModel(title: "Test2", isCompleted: true)
    
    ListRowView(item: item1)
    ListRowView(item: item2)
    
}
