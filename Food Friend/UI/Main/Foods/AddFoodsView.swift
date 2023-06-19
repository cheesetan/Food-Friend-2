//
//  AddFoodsView.swift
//  Food Friend
//
//  Created by Tristan on 19/06/2023.
//

import SwiftUI

struct AddFoodsView: View {
    
    @State var title = String()
    @State var description = String()
    @State var expiryDate = Date.now
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var FoodsVM = FoodsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                TextField("Title", text: $title, axis: .vertical)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Description (Optional)", text: $description, axis: .vertical)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                DatePicker("Expiry Date", selection: $expiryDate, in: Date()...)
                
                Divider()
                    .padding(.vertical)
                
                Button {
                    addNewFoodItem()
                } label: {
                    Text("Add Food")
                }
                .buttonStyle(DefaultButtonButtonStyle())
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    func addNewFoodItem() {
        if !title.isEmpty {
            FoodsVM.addFood(food: Food(title: title, description: description, expiryDate: expiryDate, base64Image: ""))
            dismiss.callAsFunction()
        }
    }
}

#Preview {
    AddFoodsView()
}
