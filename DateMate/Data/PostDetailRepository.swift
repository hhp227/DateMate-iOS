//
//  PostDetailRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation
import FirebaseDatabase
import Combine
import FirebaseAuth

class PostDetailRepository {
    private let rootRef: DatabaseReference
    
    private let postRef: DatabaseReference
    
    private let commentRef: DatabaseReference

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
    
    func getComments(_ key: String) -> AnyPublisher<[Comment], Error> {
        return commentRef.child(key).observer(for: .value).tryMap { result in
            result.children.map { dataSnapshot -> Comment in
                if let snapshot = dataSnapshot as? DataSnapshot, let dic = snapshot.value as? [String: Any] {
                    return Comment(
                        id: dic["uid"] as! String,
                        author: dic["author"] as! String,
                        text: dic["text"] as! String
                    )
                } else {
                    fatalError()
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addComment(_ postKey: String, _ text: String) -> AnyPublisher<DatabaseReference, Error> {
        // TODO Comment추가하는거 자체가 에러가 남
        // user 가져오는것도 다시 생각해볼것
        guard let user = Auth.auth().currentUser, let username = user.email?.split(separator: "@").first else {
            fatalError()
        }
        let dic: [String: Any] = [
            "uid": user.uid,
            "author": username,
            "text": text
        ]
        return commentRef.child(postKey).setValue(dic).eraseToAnyPublisher()
    }
    
    init() {
        self.rootRef = Database.database().reference()
        self.postRef = rootRef.child("posts")
        self.commentRef = rootRef.child("post-comments")
    }
}
