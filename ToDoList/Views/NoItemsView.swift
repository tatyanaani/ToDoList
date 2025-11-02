//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Tatyana on 25/10/2025.
//

import SwiftUI

struct NoItemsView: View {
    
    @State private var animate:Bool = false
    
    var body: some View {
        
        ScrollView { // just handy to use scroll view, so that the text is always at the top
            VStack (spacing:15) {
                Text("No items to show :(")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Click the Add button and add task you want to acomplish ⭐️")
                
                NavigationLink(destination: AddView()) {
                    Text("Add item 🫖")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(animate ? Color.accentColor : Color.secondaryAccent.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .scaleEffect(animate ? 1.05 : 1)
                .offset(y: animate ? -1.5 : 1.5)
                .shadow(color: animate ? .accentColor.opacity(0.6) : .secondaryAccent.opacity(0.6), radius: animate ? 20 : 5, x:0, y: animate ? 10: 5)
            }
            .frame(maxWidth: 400) // this way looks better in landscape mode
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear {
                addAnimation()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 1)
                    .repeatForever()
            ){
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack{
        NoItemsView()
            .navigationTitle(Text("No items"))
    }
}
