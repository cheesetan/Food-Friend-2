//
//  FoodsView.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import SwiftUI
import SwiftData

struct FoodsView: View {
    
    @State private var showingAddFoodsView = false
    @ObservedObject var FoodsVM = FoodsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offBWBackground.ignoresSafeArea()
                List {
                    Section {
                        ForEach(FoodsVM.foods) { food in
                            FoodItem(food)
                                .swipeActions {
                                    Button {
                                        delete(foodID: food.id!)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(.red)
                                }
                        }
                    } header: {
                        Text("Current Foods")
                            .textCase(nil)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                    .listRowBackground(Color.offBWForeground)
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Foods")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingAddFoodsView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddFoodsView) {
            AddFoodsView()
                .presentationDetents([.height(300)])
        }
        .onAppear {
            FoodsVM.fetchFoods()
        }
    }
    
    // MARK: - Views
    func FoodItem(_ food: Food) -> some View {
        NavigationLink {
            Text("Item at \(food.expiryDate, format: Date.FormatStyle(date: .numeric, time: .standard))")
        } label: {
            VStack(alignment: .leading) {
                Text(food.title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Expires: \(food.expiryDate, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 5)
        }
    }
    
    private func delete(foodID: String) {
        withAnimation {
            FoodsVM.removeFood(foodID: foodID)
        }
    }
}

#Preview {
    FoodsView()
}
