//
//  PostDetailRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation
import FirebaseDatabase
import Combine

class PostDetailRepository {
    private let rootRef = Database.database().reference()
    
    private let postRef: DatabaseReference

    func getPost(_ key: String) -> AnyPublisher<Post, Error> {
        return postRef.child(key).observer(for: .value).tryMap { result in
            if let dic = result.value as? [String: Any] {
                return Post(
                    id: dic["uid"] as! String,
                    author: dic["author"] as! String,
                    title: dic["title"] as! String,
                    body: dic["body"] as! String,
                    starCount: dic["starCount"] as! Int,
                    stars: [:],
                    key: result.key
                )
            } else {
                fatalError()
            }
        }.eraseToAnyPublisher()
    }
    
    init() {
        self.postRef = rootRef.child("posts")
    }
}
