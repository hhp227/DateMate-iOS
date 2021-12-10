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
            let temp = result.children.map { dataSnapshot -> Post in
                if let snapshot = dataSnapshot as? DataSnapshot, let dic = snapshot.value as? [String: Any] {
                    let post = Post.init(
                        uid: dic["uid"] as! String,
                        author: dic["author"] as! String,
                        title: dic["title"] as! String,
                        body: dic["body"] as! String,
                        starCount: dic["starCount"] as! Int,
                        stars: [:]
                    )
                    return post
                } else {
                    fatalError()
                }
            }
            print("test: \(temp)")
        }
    }
    
    func test() -> String {
        return "헬로우"
    }
}
