//
//  AddView.swift
//  ToDoList
//
//  Created by Tatyana on 23/10/2025.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var textFieldText: String = ""
    
    @State private var alertTitle: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter new task here", text:$textFieldText)
                    .padding(.horizontal, 10)
                    .frame(height: 55)
                    .background(Color.secondaryAccent.opacity(0.4))
//                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    saveButtonPressed()
                    //                    items.append(textFieldText)
                } label: {
                    Text("Save".uppercased())
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold(true)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(10)
            .alert(isPresented: $showAlert) {
               getAlert()
            }
            .navigationTitle(Text("Add an Item ➕"))
        }
    }
        
    func saveButtonPressed(){
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            dismiss()
        }
        }
        
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            if textFieldText.count == 0 {
                alertTitle = "Please enter a task ❤️"
            } else {
                alertTitle = "Please enter at least 3 characters 👀"}
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}


#Preview {
    NavigationStack {
        AddView()
    }
    .environmentObject(ListViewModel())
}

