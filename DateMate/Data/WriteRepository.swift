//
//  WriteRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation
import FirebaseDatabase

class WriteRepository {
    private let rootRef: DatabaseReference
    
    private let postRef: DatabaseReference
    
    func addPost(_ title: String, _ content: String) {
        print("addPost title: \(title), content: \(content)")
    }
    
    init() {
        self.rootRef = Database.database().reference()
        self.postRef = rootRef.child("posts")
    }
}
