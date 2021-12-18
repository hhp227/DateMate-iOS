//
//  Firebase.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/17.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import Combine

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
