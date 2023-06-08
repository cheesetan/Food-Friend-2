//
//  Functions.swift
//  Food Friend
//
//  Created by Tristan on 08/06/2023.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

// MARK: - Firestore
func addSnapShotListenerToCollection(collection: String,
                         orderedBy: String,
                         descending: Bool,
                         _ completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void
) {
    if user != nil {
        Firestore.firestore().collection(collection).order(by: orderedBy, descending: descending).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(documents))
        }
    }
}

func addSnapShotListenerToSubCollection(collection: String,
                                        collectionDocument: String,
                                        subCollection: String,
                                        orderedBy: String,
                                        descending: Bool,
                                        _ completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void
) {
    if user != nil {
        Firestore.firestore().collection(collection).document(collectionDocument).collection(subCollection).order(by: orderedBy, descending: descending).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            completion(.success(documents))
        }
    }
}

func removeDocumentFromCollection(collection: String,
                                  collectionDocument: String
) {
    if user != nil {
        Firestore.firestore().collection(collection).document(collectionDocument).delete() { err in
            if let error = err {
                print(error)
            }
        }
    }
}

func removeDocumentFromSubCollection(collection: String,
                                     collectionDocument: String,
                                     subCollection: String,
                                     subCollectionDocument: String
) {
    if user != nil {
        Firestore.firestore().collection(collection).document(collectionDocument).collection(subCollection).document(subCollectionDocument).delete() { err in
            if let error = err {
                print(error)
            }
        }
    }
}

func addDocumentToSubCollection(collection: String,
                                collectionDocument: String,
                                subCollection: String,
                                subCollectionDocumentData: [String : Any]
) {
    Firestore.firestore().collection(collection).document(collectionDocument).collection(subCollection).addDocument(data: subCollectionDocumentData)
}

func addDocumentToCollection(collection: String,
                             collectionDocumentData: [String : Any]
) {
    Firestore.firestore().collection(collection).addDocument(data: collectionDocumentData)
}

// MARK: - Authentication
func signInToAccount(email: String,
                     password: String,
                     _ completion: @escaping (Result<AuthDataResult?, Error>) -> Void
) {
    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
        guard error == nil else {
            completion(.failure(error!))
            return
        }
        
        completion(.success(result))
    }
}

func signOutOfAccount(completion: @escaping (Bool) -> Void) {
    do {
        try FirebaseAuth.Auth.auth().signOut()
    } catch {
        print("An error occurred while attempting to sign out")
    }
    
    if user == nil {
        completion(true)
    } else {
        completion(false)
    }
}
