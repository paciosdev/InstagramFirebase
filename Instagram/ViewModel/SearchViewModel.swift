//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Kekko Paciello on 27/02/21.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject{
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers(){
        COLLECTION_USERS
            .getDocuments { (snapshot, _) in
                guard let documents = snapshot?.documents else {return}
                
                //prendo gli utenti in forma di document e li converto in oggetti di tipo User
                //e poi li assegno all'array di users
                self.users = documents.compactMap{ try? $0.data(as: User.self) }
                
            }
    }
    
    func filteredUsers(_ query: String) -> [User]{
        let lowercasedQuery = query.lowercased()
        return users.filter{ $0.fullname.lowercased().contains(lowercasedQuery) || $0.username.contains(lowercasedQuery) }
    }
}
