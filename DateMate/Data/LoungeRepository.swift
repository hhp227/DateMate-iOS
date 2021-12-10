//
//  LoungeRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/09.
//

import Foundation
import FirebaseDatabase

class LoungeRepository {
    private let rootRef: DatabaseReference
    
    private var postRef: DatabaseReference
    
    init() {
        self.rootRef = Database.database().reference()
        self.postRef = rootRef.child("posts")
    }
    
    func get() {
        postRef.getData { error, result in
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            result.children.map { snapshot in
                print("Test: \(snapshot)")
            }
            
        }
    }
    
    func test() -> String {
        return "헬로우"
    }
}
