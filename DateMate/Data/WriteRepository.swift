//
//  WriteRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Combine

class WriteRepository {
    private let rootRef: DatabaseReference
    
    private let postRef: DatabaseReference
    
    func addPost(_ title: String, _ content: String) -> AnyPublisher<DatabaseReference, Error> {
        let key = postRef.childByAutoId().key
        let user = Auth.auth().currentUser
        
        if let uid = user?.uid, let key = key {
            let postValue: [String: Any] = [
                "uid": uid,
                "author": user?.email?.split(separator: "@").first ?? "author",
                "title": title,
                "body": content,
                "starCount": 0,
                "stars": [:]
            ]
            let childUpdates: [String: Any] = [
                "/posts/\(key)": postValue,
                "/user-posts/\(uid)/\(key)": postValue
            ]
            return rootRef.updateChildValues(childUpdates).eraseToAnyPublisher()
        } else {
            fatalError()
        }
    }
    
    init() {
        self.rootRef = Database.database().reference()
        self.postRef = rootRef.child("posts")
    }
}
