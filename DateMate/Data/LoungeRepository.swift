//
//  LoungeRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/09.
//

import Foundation
import FirebaseDatabase
import Combine

class LoungeRepository {
    private let rootRef: DatabaseReference
    
    private var postRef: DatabaseReference
    
    init() {
        self.rootRef = Database.database().reference()
        self.postRef = rootRef.child("posts")
    }
    
    func getPosts() -> AnyPublisher<[Post], Error> {
        return postRef.observer(for: .value).tryMap { result in
            result.children.map { dataSnapshot -> Post in
                if let snapshot = dataSnapshot as? DataSnapshot, let dic = snapshot.value as? [String: Any] {
                    let post = Post.init(
                        id: dic["uid"] as! String,
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
        }.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    func test() -> String {
        return "헬로우"
    }
}

extension DatabaseReference {
    func observer(for event: DataEventType) -> Database.Publisher {
        return Database.Publisher(for: self, on: event)
    }
    
    func observeSingleEvent(of event: DataEventType) -> Future<DataSnapshot, Never> {
        Future { promise in
            self.observeSingleEvent(of: event) { snapshot in
                promise(.success(snapshot))
            }
        }
    }
}

extension Database {
    struct Publisher: Combine.Publisher {
        typealias Output = DataSnapshot
        
        typealias Failure = Never
        
        private var reference: DatabaseReference
        
        private var event: DataEventType
        
        init(for reference: DatabaseReference, on event: DataEventType) {
            self.reference = reference
            self.event = event
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            let subscription = Subscription(subscriber: subscriber, reference: reference, event: event)
            
            subscriber.receive(subscription: subscription)
        }
    }
    
    final class Subscription<SubscriberType: Subscriber>: Combine.Subscription where SubscriberType.Input == DataSnapshot {
        private var reference: DatabaseReference?
        
        private var handle: UInt?
        
        init(subscriber: SubscriberType, reference: DatabaseReference, event: DataEventType) {
            self.reference = reference
            handle = reference.observe(event) { snapshot in
                _ = subscriber.receive(snapshot)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {
            
        }
        
        func cancel() {
            if let handle = handle {
                reference?.removeObserver(withHandle: handle)
            }
            handle = nil
            reference = nil
        }
    }
}
