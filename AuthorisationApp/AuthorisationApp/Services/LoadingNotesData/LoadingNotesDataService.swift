//
//  LoadingNotesDataService.swift
//  AuthorisationApp
//
//  Created by Matvei Khlestov on 25.06.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class LoadingNotesDataService {
    static let shared = LoadingNotesDataService()
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    func fetchNotes(completion: @escaping (Result<[Note], FetchNotesError>) -> Void) {
        guard let user = Auth.auth().currentUser else {
            print("User not authenticated.")
            completion(.failure(.userNotAuthenticated))
            return
        }
        
        let userID = user.uid
        let notesRef = db.collection("users").document(userID).collection("notes").order(by: "date", descending: true)
        
        notesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Failed to retrieve documents for user ID \(userID): \(error.localizedDescription)")
                completion(.failure(.documentRetrievalFailed(error)))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            let notes: [Note] = documents.compactMap { document in
                let data = document.data()
                
                guard let title = data["title"] as? String,
                      let text = data["text"] as? String,
                      let timestamp = data["date"] as? Timestamp else {
                    print("Invalid data for document ID \(document.documentID)")
                    return nil
                }
                
                let date = timestamp.dateValue()
                let imageUrl = data["imageUrl"] as? String
                let noteId = document.documentID
                
                return Note(id: noteId, title: title, text: text, date: date, imageUrl: imageUrl)
            }
            
            completion(.success(notes))
        }
    }
}

extension LoadingNotesDataService {
    enum FetchNotesError: Error {
        case userNotAuthenticated
        case documentRetrievalFailed(Error)
        case invalidData
    }
}
