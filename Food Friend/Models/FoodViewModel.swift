//
//  FoodsViewModel.swift
//  Food Friend
//
//  Created by Tristan on 07/06/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Food: Codable, Identifiable {
    var id: String?
    var title: String
    var description: String
    var expiryDate: Date
    var base64Image: String
}

final class FoodsViewModel: ObservableObject {
    
    @Published var foods = [Food]()
        
    func fetchFoods() {
        addSnapShotListenerToSubCollection(collection: "users",
                                           collectionDocument: userUID!,
                                           subCollection: "foods",
                                           orderedBy: "addedAt",
                                           descending: true
        ) { response in
            switch response {
                case .success(let documents):
                    self.foods = documents.map { docSnapshot -> Food in
                        
                        let data = docSnapshot.data()
                        let id = docSnapshot.documentID
                        
                        let title = data["title"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let expiryDate = data["expiryDate"] as? Date ?? Date()
                        let base64Image = data["base64Image"] as? String ?? ""
                        
                        return Food(id: id, title: title, description: description, expiryDate: expiryDate, base64Image: base64Image)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func removeFood(foodID: String) {
        removeDocumentFromSubCollection(collection: "users", collectionDocument: userUID!, subCollection: "foods", subCollectionDocument: foodID)
        fetchFoods()
    }
    
    func addFood(food: Food) {
        addDocumentToSubCollection(collection: "users", collectionDocument: userUID!, subCollection: "foods", subCollectionDocumentData: ["addedAt" : Date() ,"title" : food.title, "description" : food.description, "expiryDate" : food.expiryDate, "base64Image" : food.base64Image])
        fetchFoods()
    }
}


